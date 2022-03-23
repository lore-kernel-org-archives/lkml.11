Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD05CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 05:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiCWFhG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 01:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiCWFhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:37:01 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E3170CFB;
        Tue, 22 Mar 2022 22:35:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22N5ZT4T045069;
        Wed, 23 Mar 2022 00:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648013729;
        bh=cnxKwREyex8W9TaoJH3a6mh/x2YhctnazmmmL+X6/Yw=;
        h=From:To:CC:Subject:Date;
        b=N4MDFI84hjyKj6AKp0WBnd2VDBxGzcDZyZ8t0Z2uzKSS/3bh19hyoJOZGNqkeiZ7h
         NCGSoqtfWCIpvkvrKI0BpdKOMZb7ZnWR85wpxpPYVjFD9fAyz31MmiC43aK8cx/bIO
         qG2NDRmQwO3LECNC8V4csUKZqh7eJ/9eWi66f9Aw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22N5ZTDE095525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Mar 2022 00:35:29 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Mar 2022 00:35:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Mar 2022 00:35:28 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22N5ZOoO038635;
        Wed, 23 Mar 2022 00:35:25 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 0/2] AM62: Add support for AM62 USB wrapper driver
Date:   Wed, 23 Mar 2022 11:05:22 +0530
Message-ID: <20220323053524.7009-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for AM62 USB wrapper driver
and its corresponding bindings.

Aswath Govindraju (2):
  dt-bindings: usb: Add documentation for AM62 USB Wrapper module
  drivers: usb: dwc3: Add AM62 USB wrapper driver

 .../devicetree/bindings/usb/ti,am62-usb.yaml  |  98 +++
 drivers/usb/dwc3/Kconfig                      |   9 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-am62.c                  | 577 ++++++++++++++++++
 4 files changed, 685 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
 create mode 100644 drivers/usb/dwc3/dwc3-am62.c

-- 
2.17.1

