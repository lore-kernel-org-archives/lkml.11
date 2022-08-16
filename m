Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B70C3F6B0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 10:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiHPKGL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiHPKFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19105C6CD0;
        Tue, 16 Aug 2022 02:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F6161255;
        Tue, 16 Aug 2022 09:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7680CC433D6;
        Tue, 16 Aug 2022 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660641977;
        bh=HH0LKZi3cN9iX3f5XbyBtL6oi9LZPkk8/xXhG4QPW80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2ZnPky8rXQ5BjWdDQNabGVWclVBlCj+X50TlFjw93zEzKIv6w81vP4s9yU+ZwGVD
         x9GnxgBfA6hNlC05qTuaVoEbFTpnXIEMt9uLe1n0jwhnaNoTFepvrxqr+q+7r+v7Q6
         CRk3jGUp//ZprOKphnK7zXQq/brx/Mct2PIxjyb4=
Date:   Tue, 16 Aug 2022 11:26:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stern@rowland.harvard.edu,
        syzbot+b0de012ceb1e2a97891b@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.15 103/779] USB: gadget: Fix use-after-free Read in
 usb_udc_uevent()
Message-ID: <YvtitluWL33RPxSW@kroah.com>
References: <20220815180337.130757997@linuxfoundation.org>
 <20220815180341.711918032@linuxfoundation.org>
 <TYWPR01MB94203CD9FB4E48250368E1D7926B9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYWPR01MB94203CD9FB4E48250368E1D7926B9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:43:11AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
> 
> This patch is related to "fc274c1e9973 "USB: gadget: Add a new bus for gadgets".
> 5.15.y, 5.10.y, 5.5.y and 4.19.y tree doesn't include it, so it's unnecessary. Please drop each tree.

Ick, good catch, my scripts got confused here.  Now dropped from
everywhere.

thanks,

greg k-h
