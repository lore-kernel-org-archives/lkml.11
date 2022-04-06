Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB819C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 16:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbiDFQdO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbiDFQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:32:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B603119481D;
        Wed,  6 Apr 2022 06:52:25 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 236DqJL0112009;
        Wed, 6 Apr 2022 08:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649253139;
        bh=AQtmCU8nSw+pQUsM07priatShylKCYZ0upOcmmY/1FU=;
        h=From:To:CC:Subject:Date;
        b=BqUeqp/+TzacMy9jQdjsNvRJiB2MJW4gyzBCjAM5Zb2wiMY30Kzu1HQR750uVaXvv
         cKRwXviWs8eXflbgweaBlWQ/krr+SgJNeLGKfP4c1QLyoHDR2THNJi+UTinNxA61Us
         JPLeAc0sCR7JnmQ3CTXegxcOAGfIX1nsDXFhy9vQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 236DqJmB089706
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Apr 2022 08:52:19 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Apr 2022 08:52:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Apr 2022 08:52:19 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 236DqFsn079424;
        Wed, 6 Apr 2022 08:52:16 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] AM62: Add support for AM62 USB wrapper driver
Date:   Wed, 6 Apr 2022 19:22:09 +0530
Message-ID: <20220406135214.6989-1-a-govindraju@ti.com>
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

changes since v2:
- Removed the implementation of detecting the role from the wrapper
  driver and moved the implementation to using linux,extcon-usb-gpio
  driver for role detection.
- Updated the binding documentation and example to reflect the same.

changes since v1:
- Fixed the error with dev_pm_ops uninitialization, in patch 2.
  This was reported by kernel test bot
- In patch 1, made correction in grammer of clocks property description
  and added maxItems in the interrupts property based on comments
  received from Roger
- In patch 1, corrected the title, fixed the description of
  ti,syscon-phy-pll-refclk, added pattern properties and child node
  in the example based on the comments from Krzysztof. 

Aswath Govindraju (2):
  dt-bindings: usb: Add documentation for AM62 USB Wrapper module
  drivers: usb: dwc3: Add AM62 USB wrapper driver

 .../devicetree/bindings/usb/ti,am62-usb.yaml  | 115 +++++
 drivers/usb/dwc3/Kconfig                      |   9 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-am62.c                  | 446 ++++++++++++++++++
 4 files changed, 571 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
 create mode 100644 drivers/usb/dwc3/dwc3-am62.c

-- 
2.17.1
