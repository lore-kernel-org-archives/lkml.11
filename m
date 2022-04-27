Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50103C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 13:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiD0Nqp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiD0Nqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:46:39 -0400
Received: from vsp-unauthed02.binero.net (vsp-unauthed02.binero.net [195.74.38.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6993B396F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:43:27 -0700 (PDT)
X-Halon-ID: fc482e6e-c62f-11ec-9627-0050569116f7
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id fc482e6e-c62f-11ec-9627-0050569116f7;
        Wed, 27 Apr 2022 15:43:25 +0200 (CEST)
From:   Andreas Larsson <andreas@gaisler.com>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-kernel@vger.kernel.org, software@gaisler.com
Subject: [PATCH 0/3] can: grcan: Bug fixes
Date:   Wed, 27 Apr 2022 15:43:04 +0200
Message-Id: <20220427134307.22981-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches
* makes sure that DMA memory is allocated properly
* avoids the tx errata workaround needlessly being applied
* fixes a bug where the driver can be left hanging without interrupts enabled

Andreas Larsson (2):
  can: grcan: Fix broken system id check for errata workaround needs
  can: grcan: Only use the napi poll budget for rx

Daniel Hellstrom (1):
  can: grcan: use ofdev->dev when allocating DMA memory

 drivers/net/can/grcan.c | 45 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

-- 
2.17.1

