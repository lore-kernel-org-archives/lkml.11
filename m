Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D81C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Mar 2022 14:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiCEOmb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCEOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:42:30 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C80A4348A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:41:40 -0800 (PST)
Received: from dslb-084-059-247-134.084.059.pools.vodafone-ip.de ([84.59.247.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nQVbD-0007ms-Gr; Sat, 05 Mar 2022 15:41:35 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/5] staging: r8188eu: clean up update_recvframe_attrib_88e
Date:   Sat,  5 Mar 2022 15:41:12 +0100
Message-Id: <20220305144117.1380534-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set cleans up the update_recvframe_attrib_88e function.

Martin Kaiser (5):
  staging: r8188eu: remove tmp variable in update_recvframe_attrib_88e
  staging: r8188eu: summarize declaration and assignment
  staging: r8188eu: don't initialize drvinfo_sz to 0
  staging: r8188eu: remove unnecessary casts
  staging: r8188eu: remove comments in update_recvframe_attrib_88e

 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 72 ++++++++-----------
 1 file changed, 28 insertions(+), 44 deletions(-)

-- 
2.30.2

