Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E97C6FA82
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 22:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiIAWnh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiIAWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:43:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4636A485;
        Thu,  1 Sep 2022 15:43:32 -0700 (PDT)
Received: from localhost (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C7FB96601EAE;
        Thu,  1 Sep 2022 23:43:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662072210;
        bh=Se+P/2OSMvzpNPBSCpKRrCFWILF2FxskQ8Df/RF/9Lg=;
        h=From:To:Cc:Subject:Date:From;
        b=LVv576YF5B6AqEwx5ElJjwCiOFMBHSLVVhBFxXTqueF9ZVLGGkSAt2AcQyQ+RNhMN
         q3uEgPvJGXBC8ZnuI8DkcTDvygvMmxtn4qRD9YKGceUQdNkm/3FI0kGhlCEdv0OlTS
         k2f1QEWXlJaXcHBFwsq/5HwMuK/5m3CStFraoTzlRtVSdd+TmUc7ktTONuBOfy2l28
         D1Is/8oshHQZYKa52DwMKW6g5HILCxaYU81+dffXuPKY7LwiW8nuwNyGgId5GoXzqe
         jNnaUzm1eUlrMVA/7auhJAm9k/0azYBRuwpr2PmNh6KlYoD+NqqgzNVmck0HeFwJwY
         nGoSnYe9X12wg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 0/3] Enable initial support for StarFive VisionFive V1 SBC
Date:   Fri,  2 Sep 2022 01:42:50 +0300
Message-Id: <20220901224253.2353071-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The StarFive VisionFive V1 SBC [1] is similar with the already supported
BeagleV Starlight Beta board, both being based on the StarFive JH7100 SoC.

In addition to documenting the necessary compatibles, this patch series 
moves most of the content from jh7100-beaglev-starlight.dts to a new file
jh7100-common.dtsi, to be shared between the two boards.

No other changes are required in order to successfully boot the board.

[1] https://github.com/starfive-tech/VisionFive

Cristian Ciocaltea (3):
  dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
  riscv: dts: starfive: Add common DT for JH7100 based boards
  riscv: dts: starfive: Add StarFive VisionFive V1 device tree

 .../devicetree/bindings/riscv/starfive.yaml   |   3 +
 arch/riscv/boot/dts/starfive/Makefile         |   2 +-
 .../dts/starfive/jh7100-beaglev-starlight.dts | 153 +----------------
 .../boot/dts/starfive/jh7100-common.dtsi      | 161 ++++++++++++++++++
 .../jh7100-starfive-visionfive-v1.dts         |  20 +++
 5 files changed, 186 insertions(+), 153 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7100-common.dtsi
 create mode 100644 arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts

-- 
2.37.2

