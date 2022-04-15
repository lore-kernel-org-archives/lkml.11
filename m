Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E1FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 13:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354094AbiDONo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiDONo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:44:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D98C3DA65;
        Fri, 15 Apr 2022 06:42:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FDgLFj128739;
        Fri, 15 Apr 2022 08:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650030141;
        bh=cH183o782eQJkq7K4fNuyC9dela9Myj5IlwJ1MJWLA8=;
        h=From:To:CC:Subject:Date;
        b=jcju/jl8cfYIUDdt8qN55ITwAdfUUBFatkvenfqg+HGIm/3nUD3iOJVIaO6S/6Zvf
         2bcsDstDvml/nm1MDrvS+HAOrhLO62DjxcTp8bja0TfsWeOY6H23JX4w4Mna1a7m08
         3nF2GtoR3bBgtTmqO+WXcqz/RNeqciQ1xyvMdzLk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FDgLcR032612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 08:42:21 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 08:42:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 08:42:20 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FDgEjg022953;
        Fri, 15 Apr 2022 08:42:16 -0500
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     <ssantosh@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nm@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH 0/2] clk: keystone: Add support for AM62 specific ewpm-tbclk
Date:   Fri, 15 Apr 2022 16:41:40 +0300
Message-ID: <20220415134142.12141-1-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for TI's AM62 specific time-based
submodule clock (tbclk). On AM62 SoCs we have to provide 3 tbclk
instances, as the SoC features 3 EPWM modules.

Georgi Vlaev (2):
  clk: keystone: syscon-clk: Add support for AM62 epwm-tbclk
  dt-bindings: clock: ehrpwm: Add AM62 specific compatible

 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml         |  1 +
 drivers/clk/keystone/syscon-clk.c                     | 11 +++++++++++
 2 files changed, 12 insertions(+)


base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
-- 
2.30.2

