Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D739FECAAD1
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 09:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiIAJLA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIAJK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:10:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA14C0E51;
        Thu,  1 Sep 2022 02:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42FA4615DD;
        Thu,  1 Sep 2022 09:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F629C433C1;
        Thu,  1 Sep 2022 09:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662023456;
        bh=V8W1qWBzbOfr3oLOrXIq2DN60aWgiV3ZvXoQRkxNnRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvyBKygTozO7r+N51KTabzvhplxyBmaD0wxD0W/yM/TPc5I4FgFD3sI5Lzxb4RVrE
         QtZiSBRL1r5iH2S5cN1J6UotyUp5Wjuhqv0/P9bepMFzB4ZNSH4hLPJQogMobnFPi9
         /FePonJn+4eIQJbW80sc+zNWrLe5YrCXuvsS7k4Y=
Date:   Thu, 1 Sep 2022 11:10:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.0-rc4
Message-ID: <YxB3GHMOEdHv0zls@kroah.com>
References: <YxB1eeDSKt+Ei5kf@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxB1eeDSKt+Ei5kf@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 11:03:53AM +0200, Johan Hovold wrote:
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.0-rc4

Pulled and pushed out, thanks.

greg k-h
