Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9641C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 17:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377151AbiCYREx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbiCYREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:04:46 -0400
Received: from mx.msync.work (mx.msync.work [51.91.38.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC363F6;
        Fri, 25 Mar 2022 10:03:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0F7232041;
        Fri, 25 Mar 2022 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648227308; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding; bh=2Z9kbaIxV2YtXn9npaupo8QgaDLgj6YOX0GWnSHvOAM=;
        b=mYg7YTNYbC0EF7KlDstBcBvIlGJJYmSib8o1ozqXxnv8/MKDQ1IEQQF5vu5grX0DPCk10d
        pDg3tGT1qoUMx6g4HQRkinZfCloc0xAJPcJ+/p9o4MRvgDdlPZLRo1EkrE9f/gE4O20qlE
        VO6d089C0YHKzDmTKzXaAF9/FPtrueL3N9mXeT+GRaPw2d2iZD4c0CsBpGqe9xkJZYdGq7
        LejGM4JzytsHT0NBYpAO304h+AR7bU/uWJ/WSCAX7pvvtp+GKtrgRSP4S7QPwQOJnUzY2U
        LsYPWmBOLCGencPRX0hJtbgguA5rrk878vn/2JQJ/fiEokd2WvZ32TzDf22ECA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] arm64: meson: update dts for JetHub devices
Date:   Fri, 25 Mar 2022 19:54:58 +0300
Message-Id: <20220325165501.81551-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update dts for JetHub H1:
- add bluetooth node for RTL8822CS uart port

Update dts for JetHub D1:
- add ZigBee serial alias (ttyAML2) for backward compatibility
- update voltage regulators and SDIO config to match board's reference design

Vyacheslav Bocharov (3):
  arm64: meson: add to dts for JetHub H1 bluetooth node
  arm64: meson: dts: update dts for JetHub D1
  arm64: meson: fix sdio in dts for JetHub D1

 .../amlogic/meson-axg-jethome-jethub-j100.dts   | 17 +++++++++++++----
 .../meson-gxl-s905w-jethome-jethub-j80.dts      |  5 +++++
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.30.2

