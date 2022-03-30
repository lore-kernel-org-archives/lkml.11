Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63C9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 20:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350916AbiC3UOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiC3UOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:14:11 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2A06623A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:12:25 -0700 (PDT)
Received: from dslb-178-004-172-185.178.004.pools.vodafone-ip.de ([178.4.172.185] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nZefx-0007FS-5x; Wed, 30 Mar 2022 22:12:17 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/2] staging: r8188eu: remove debug code for dumping packets
Date:   Wed, 30 Mar 2022 22:12:08 +0200
Message-Id: <20220330201210.175941-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the remains of debug code to print incoming and outgoing packets.

Martin Kaiser (2):
  staging: r8188eu: remove the "dump rx packet" fragments
  staging: r8188eu: remove the "dump tx packet" fragments

 drivers/staging/r8188eu/core/rtw_recv.c        |  4 ----
 drivers/staging/r8188eu/hal/usb_halinit.c      | 12 ------------
 drivers/staging/r8188eu/include/hal_intf.h     |  2 --
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  3 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c   |  7 -------
 5 files changed, 28 deletions(-)

-- 
2.30.2

