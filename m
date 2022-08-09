Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08708C19F2D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 15:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbiHIP0E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbiHIPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:25:52 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBAA6371;
        Tue,  9 Aug 2022 08:25:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4CF3BFADC;
        Tue,  9 Aug 2022 17:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660058746; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=YoX4ep1S3jq9Mf8bS1Qiiua+QDySidTu567sIIExWhE=;
        b=wU9yxr+HFqkN5FMq2QIPANZNdPogLIea6bkDJAN5aaXaPq03IZzQeoVdVkzdTgxUqR+pcd
        unSZVb6PMaUt5ZQfidaR/+RT6dCZ8Xz9BGpvWTO0eWv80MkNFDBaZu1d1njxDaOn2OeaHk
        4tqM4877wNmdlQHrkqiYqip8sQoBqG28HC6RyDvmysp5pw0kT9A+sricNdxrdB9UVfHMf3
        kjRSFU7hl8ps37A641VTfKAVoYu4IyclGrskaBqx2GKtFcKEIOW2u8B++1dKXzW/6cK386
        iWYIGSjhF84+EC71NYtX2JSAkJohYdT0iD+veCS6eC+rXQKtNl1UDWb/p7TV4w==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, soc@kernel.org
Subject: [PATCH 0/4] ARM: dts: imx6ul-kontron: Improve devicetrees
Date:   Tue,  9 Aug 2022 17:25:27 +0200
Message-Id: <20220809152534.292034-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This series contains some simplifications to the devicetree file structure
and updates the model names of the boards to match what is used officially
by the Kontron marketing.

The first patch also updates the bindings to match up with the changes applied
in the following patches.

This series doesn't contain any functional changes.

Frieder Schrempf (4):
  dt-bindings: arm: fsl: imx6ul-kontron: Update bindings
  ARM: dts: imx6ul-kontron: Simplify devicetree structure
  ARM: dts: imx6ul-kontron: Add imx6ull-kontron-n641x-s to Makefile
  ARM: dts: imx6ul-kontron: Adjust board and SoM model strings

 .../devicetree/bindings/arm/fsl.yaml          | 31 ++++++--------
 arch/arm/boot/dts/Makefile                    |  5 ++-
 .../boot/dts/imx6ul-kontron-n6310-som.dtsi    | 41 -------------------
 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts  | 16 --------
 .../boot/dts/imx6ul-kontron-n6311-som.dtsi    | 40 ------------------
 ...s-43.dts => imx6ul-kontron-n631x-s-43.dts} |  8 ++--
 ...n6310-s.dts => imx6ul-kontron-n631x-s.dts} |  6 +--
 .../boot/dts/imx6ul-kontron-n631x-som.dtsi    | 14 +++++++
 .../dts/imx6ul-kontron-n6x1x-som-common.dtsi  | 15 +++++++
 .../boot/dts/imx6ull-kontron-n6411-som.dtsi   | 40 ------------------
 ...6411-s.dts => imx6ull-kontron-n641x-s.dts} |  6 +--
 .../boot/dts/imx6ull-kontron-n641x-som.dtsi   | 13 ++++++
 12 files changed, 67 insertions(+), 168 deletions(-)
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s-43.dts => imx6ul-kontron-n631x-s-43.dts} (93%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s.dts => imx6ul-kontron-n631x-s.dts} (65%)
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n631x-som.dtsi
 delete mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
 rename arch/arm/boot/dts/{imx6ull-kontron-n6411-s.dts => imx6ull-kontron-n641x-s.dts} (60%)
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-n641x-som.dtsi

-- 
2.37.1
