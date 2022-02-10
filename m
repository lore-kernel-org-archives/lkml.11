Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB60C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 06:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiBJGxp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 01:53:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiBJGxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:53:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5851221B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5B2F61C19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EDAC004E1;
        Thu, 10 Feb 2022 06:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644476025;
        bh=CQSix5a+5H/ZM9UAfPny9dzwDbc7P5NWY/v4mbg44C0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHNbzPFjeIFSruAbQX7GnZtj7bB7Qhoe+WtZ/x0fL95JS3GoFtoXWuSfTM4OHt5On
         Xmnerns6gOBLzyKw11VJPtVuUIeptXqKefG9OpMMB9nHN7ISXZCHXLKD07sQGFyQHW
         0oMclZljut4Pa0bc3aO+GhgcHtfObt2O+03Q8owU=
Date:   Thu, 10 Feb 2022 07:53:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leonardo Araujo <leonardo.aa88@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: core: Avoid CamelCase: <bEnterPS>
Message-ID: <YgS2dAHofenuyVjg@kroah.com>
References: <20220209205740.9926-1-leonardo.aa88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209205740.9926-1-leonardo.aa88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 05:57:40PM -0300, Leonardo Araujo wrote:
> Fixed a coding style issue.

Please read the kernel documentation for how to write better subject
lines and changelog texts.  These need a lot of work, you can't just put
the checkpatch message in the subject and then nothing in the changelog
body.

> 
> Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index e42119e16284..4ec4da6d3078 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -880,7 +880,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan)
>  
>  static void traffic_status_watchdog(struct adapter *padapter)
>  {
> -	u8	bEnterPS;
> +	u8	b_enter_ps;

No, think about what you are changing here.  Why keep the "b" at all?
What does this variable name?  Why was there a "b" to start with?


>  	u8	bBusyTraffic = false, bTxBusyTraffic = false, bRxBusyTraffic = false;


What about all of these other variables, why ignore them and not send a
patch series to fix them all up?

Remember where the "b" comes from, this is "hungarian notation" and is
trying to describe the type of the variable, which makes no sense in
this century.  Please do not keep it around for no reason at all.

thanks,

greg k-h
