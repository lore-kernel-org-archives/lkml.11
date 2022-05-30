Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E46C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 10:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiE3KKw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 06:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiE3KKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:10:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1177B9D6;
        Mon, 30 May 2022 03:10:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24UAAace128818;
        Mon, 30 May 2022 05:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653905436;
        bh=gz3fxtQ6S616Sg8YqQYSGp5F9mXup9910Q09FuteyMQ=;
        h=From:To:CC:Subject:Date;
        b=bgGtCL+x7sAHHrarXs7O0vP4ikeSJhEB/Noft+O8IqlINAgdAkLr6ag3XxbWMubxu
         DpOqlTvDqKi2gvFBvjdO3PdLoUc3yuO6PWVJ6qkPHb8/nA9emRM/hEflg1Uj9RWS/U
         jOVLFG9A9E2Up+r9NG6KzHFaD8GmxHvEv6mEWITA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24UAAarS056916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 May 2022 05:10:36 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 30
 May 2022 05:10:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 30 May 2022 05:10:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24UAAYYV027667;
        Mon, 30 May 2022 05:10:35 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v4 0/3] Enable RPi header on j721e sk
Date:   Mon, 30 May 2022 15:40:28 +0530
Message-ID: <20220530101031.11357-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches enables RPi header
on j721e sk. It is a 40 pin io expasion header which
brings out i2c5, ehrpwm 2,3 and some pins of gpio 0,1

v4:
   - Correct the node name in dt binding example

v3:
   - Change node name from clock to clock-controller
   - Add correct description for clock-controller node

v2:
   - Add full path for clock property $ref
   - Remove the discription for clock pattern property,
     since $ref is added
   - Remove the label in the example
   - Fix the indentation in the example

Rahul T R (1):
  dt-bindings: mfd: ti,j721e-system-controller: Add clock property

Sinthu Raja (1):
  arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header

Vijay Pothukuchi (1):
  arm64: dts: ti: k3-j721e-*: Add dts nodes for EHRPWMs

 .../mfd/ti,j721e-system-controller.yaml       |  12 +++
 .../dts/ti/k3-j721e-common-proc-board.dts     |  24 +++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  62 ++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 101 +++++++++++++++++-
 4 files changed, 193 insertions(+), 6 deletions(-)

-- 
2.17.1

