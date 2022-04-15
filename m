Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ECCC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 10:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352410AbiDOKw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 06:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352397AbiDOKwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:52:39 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760CF344DD;
        Fri, 15 Apr 2022 03:50:10 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout4.routing.net (Postfix) with ESMTP id 90FCB10081B;
        Fri, 15 Apr 2022 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650019807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rWSR2rltVSUqvyGXpreg4LKaYlPdzHCHZKQnQuzQnac=;
        b=xUd3kNr59wxtB4msvT494ZDjLtPGFK2Eao5k2wCfFkX797f0ZGnEx7MqIRLZRGsNmeoq/W
        HwUfWTLtSNjBicxyr4ZSq0QYmBhKX7lVsQkxLxOBpH7TAtpV4lw0IDwN+xALSspcFa/WeV
        bLFQvXcg0Su6INsAnWX9cg51/g3bJew=
Received: from localhost.localdomain (fttx-pool-217.61.153.244.bambit.de [217.61.153.244])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 641E3100501;
        Fri, 15 Apr 2022 10:50:06 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add hdmi Support for BPI-R2-Pro
Date:   Fri, 15 Apr 2022 12:49:48 +0200
Message-Id: <20220415104951.27104-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 56e09033-23d0-4d9f-9f04-5ff42bb46aaa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series adds changes to Device  tree for Bananapi-R2-Pro to support
HDMI output.

It is based on "drm/rockchip: RK356x VOP2 support"
v10:
https://patchwork.kernel.org/project/linux-rockchip/list/?series=630407

Frank Wunderlich (3):
  arm64: dts: rockchip: set display regulators to always-on on
    BPI-R2-Pro
  arm64: dts: rockchip: enable vop2 and hdmi tx on BPI-R2-Pro
  arm64: dts: rockchip: enable the gpu on BPI-R2-Pro

 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

-- 
2.25.1

