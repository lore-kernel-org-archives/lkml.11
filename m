Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FDEC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Jul 2022 15:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGJPWB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Jul 2022 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGJPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF3E004
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:21:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F11D261242
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 15:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06785C3411E;
        Sun, 10 Jul 2022 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657466511;
        bh=eNc0PmLL2Ko+1em/1YMUW9O7J4oGLSyO49CmNZWDL3s=;
        h=Date:From:To:Cc:Subject:From;
        b=YneoYT5w0sWI7g9Z1bKENxDy4CQT+b1TX+xAweyPjteHMlt4UmDfzA5Y1H+8NWxRq
         NWyeHUtOSJNbqs7R1RqOjiGSnDb3q9iGgRXvSF65XhvuGzjuW1I0tvBETiq6o4WHb1
         bAU34HuXZoR0mGUJFueVryr+9DmQo6OTjgVJyo1E=
Date:   Sun, 10 Jul 2022 17:21:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fix for 5.19-rc6
Message-ID: <YsrujMflc51TazvD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.19-rc6

for you to fetch changes up to ee6c6e7342471d468096a16bee9f89b5a6c1e39d:

  staging/wlan-ng: get the correct struct hfa384x in work callback (2022-07-01 09:58:58 +0200)

----------------------------------------------------------------
Staging driver fix for 5.19-rc6

Here is a single staging driver fix for a reported problem that showed
up in 5.19-rc1 in the wlan-ng driver.  It has been in linux-next for a
week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Davidlohr Bueso (1):
      staging/wlan-ng: get the correct struct hfa384x in work callback

 drivers/staging/wlan-ng/hfa384x_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
