Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9507C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 17:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiDFR0Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbiDFRZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:25:53 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 22B8F3BF8BA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:24:46 -0700 (PDT)
Received: (qmail 190547 invoked by uid 1000); 6 Apr 2022 11:24:46 -0400
Date:   Wed, 6 Apr 2022 11:24:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
References: <20220406092445.215288-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406092445.215288-1-mdevaev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 12:24:45PM +0300, Maxim Devaev wrote:
> Using the SIGUSR1 signal sent to the "file-storage" thread
> from the userspace, it is possible to break IO operations
> that block the gadget. Thus, it is possible to implement
> "force eject" without stopping the gadget and umounting
> it from the host side.

It's not clear to me how breaking I/O operations allows you to do a 
"force eject".  It seems that what you would need is something like 
fsg_store_file() that omits the curlun->prevent_medium_removal check.
Interrupting a lengthy I/O operation doesn't really have anything to do 
with this.

> There are two problems here:
> 
>   - In order to send a signal, we need to find the thread
>     in procfs, but if several mass storage gadgets are created
>     in the system, each process has the same name and it is
>     impossible to distinguish one gadget from another.
> 
>   - Root privileges are required to send the signal.
> 
> The proposed "break_io" interface solves both problems.
> It allows us to get rid of the procfs search and delegate
> sending the signal to a regular user.

Or to keep this ability restricted to the superuser, if that is desired.

> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 6ad669dde41c..e9b7c59e1dc4 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -3239,6 +3239,27 @@ static ssize_t fsg_opts_stall_store(struct config_item *item, const char *page,
>  
>  CONFIGFS_ATTR(fsg_opts_, stall);
>  
> +static ssize_t fsg_opts_break_io_store(struct config_item *item,
> +				       const char *page, size_t len)
> +{
> +	struct fsg_opts *opts = to_fsg_opts(item);
> +	unsigned long flags;
> +
> +	mutex_lock(&opts->lock);
> +	spin_lock_irqsave(&opts->common->lock, flags);
> +
> +	if (opts->common->thread_task)
> +		send_sig_info(SIGUSR1, SEND_SIG_PRIV,
> +			      opts->common->thread_task);

You should not call send_sig_info() directly; instead call 
raise_exception().  It already does the work you need (including some 
things you left out).

Alan Stern

> +
> +	spin_unlock_irqrestore(&opts->common->lock, flags);
> +	mutex_unlock(&opts->lock);
> +
> +	return len;
> +}
> +
> +CONFIGFS_ATTR_WO(fsg_opts_, break_io);
> +
>  #ifdef CONFIG_USB_GADGET_DEBUG_FILES
>  static ssize_t fsg_opts_num_buffers_show(struct config_item *item, char *page)
>  {
> @@ -3283,6 +3304,7 @@ CONFIGFS_ATTR(fsg_opts_, num_buffers);
>  
>  static struct configfs_attribute *fsg_attrs[] = {
>  	&fsg_opts_attr_stall,
> +	&fsg_opts_attr_break_io,
>  #ifdef CONFIG_USB_GADGET_DEBUG_FILES
>  	&fsg_opts_attr_num_buffers,
>  #endif
> -- 
> 2.35.1
> 
