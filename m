Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E78C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 03:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiBXDAu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 22:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiBXDAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:00:47 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5B617584A;
        Wed, 23 Feb 2022 19:00:14 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nN4MW-004RC0-Bt; Thu, 24 Feb 2022 03:00:12 +0000
Date:   Thu, 24 Feb 2022 03:00:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/exec.c: Avoid a race in formats
Message-ID: <Yhb0vB/G2a92zJJP@zeniv-ca.linux.org.uk>
References: <20220223231752.52241-1-ppbuk5246@gmail.com>
 <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
 <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 08:59:59AM +0900, Yun Levi wrote:

> I think if someone wants to control their own binfmt via "ioctl" not
> on time on LOAD.
> For example, someone wants to control exec (notification,
> allow/disallow and etc..)
> and want to enable and disable own's control exec via binfmt reg / unreg
> In that situation, While the module is loaded, binfmt is still live
> and can be reused by
> reg/unreg to enable/disable his exec' control.

Er...  So have your ->load_binary() start with
	if (I_want_it_disabled)
		return -ENOEXEC;
and be done with that.

The only caller of that thing is
        list_for_each_entry(fmt, &formats, lh) {
		if (!try_module_get(fmt->module))
			continue;
		read_unlock(&binfmt_lock);

		retval = fmt->load_binary(bprm);

		read_lock(&binfmt_lock);
		put_binfmt(fmt);
		if (bprm->point_of_no_return || (retval != -ENOEXEC)) {
			read_unlock(&binfmt_lock);
			return retval;
		}
	}
so returning -ENOEXEC is equivalent to not having it in the list.
IDGI...  Why bother unregistering/re-registering/etc.?
