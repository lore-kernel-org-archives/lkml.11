Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19F2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 15:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbiEJPf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243412AbiEJPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:35:07 -0400
Received: from mail-m17638.qiye.163.com (mail-m17638.qiye.163.com [59.111.176.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97ADB7D9;
        Tue, 10 May 2022 08:30:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.23.13.247])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id ED95D1C0190;
        Tue, 10 May 2022 23:30:19 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 0/1] arm64: dts: allwinner: h6: Enable CPU opp tables for OrangePi One Plus
Date:   Tue, 10 May 2022 23:30:05 +0800
Message-Id: <20220510153006.279233-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIeShhWHUwZHk1MThpCTh
        9NVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pwg6SSo6OT0xUVEqCQssDUsB
        DgEKC0xVSlVKTU5JSkJNTUlLTkxPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VUlIVUpIVUlPTFlXWQgBWUFKTkNLNwY+
X-HM-Tid: 0a80ae97b78dd993kuwsed95d1c0190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2:
* Remove regulator-enable-ramp-delay for cpu and gpu.

Chukun Pan (1):
  arm64: dts: allwinner: h6: Enable CPU opp tables for OrangePi One Plus

 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.25.1

