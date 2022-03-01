Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB251C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 10:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiCAK31 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCAK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:29:24 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1284F9F5;
        Tue,  1 Mar 2022 02:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646130524; x=1677666524;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JKZs6BHGiuv84Q3F+KTWPFdbfUxZqZS6HBwpb7TOq2E=;
  b=AX5I7sB2NIoxvl/tcAB1FdoNImF7K1vn8b/hjX8+lHK4io/RM1OEpR0x
   DyW85XFxybtPt1auMVHUtcDFTpYk9Y7Ex6AWjB8OijRcg320cskP+n8Kt
   ZsycNmPGvGJw0WiTuVnAbbd51n1UiIx2btc6xMwyScttYiCEgtnpbf6jV
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2022 02:28:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 02:28:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 02:28:42 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 02:28:38 -0800
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v2 0/3] Refactor xhci quirks and plat private data
Date:   Tue, 1 Mar 2022 15:58:24 +0530
Message-ID: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v2:
Added a PATCH 2/3 to remove unwanted header inclusion.
Fixed minor nitpicks in PATCH 3/3.

Pavankumar Kondeti (1):
  usb: xhci: refactor quirks and plat private data

Sandeep Maheswaram (2):
  usb: xhci: Remove unwanted header inclusion
  usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT

 drivers/usb/cdns3/host.c        |  2 +-
 drivers/usb/dwc3/host.c         | 13 ++++++++
 drivers/usb/host/xhci-plat.c    |  3 +-
 drivers/usb/host/xhci-plat.h    | 24 ---------------
 drivers/usb/host/xhci-rcar.c    |  3 +-
 drivers/usb/host/xhci.h         | 60 ++++--------------------------------
 include/linux/usb/xhci-plat.h   | 24 +++++++++++++++
 include/linux/usb/xhci-quirks.h | 67 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 115 insertions(+), 81 deletions(-)
 delete mode 100644 drivers/usb/host/xhci-plat.h
 create mode 100644 include/linux/usb/xhci-plat.h
 create mode 100644 include/linux/usb/xhci-quirks.h

-- 
2.7.4

