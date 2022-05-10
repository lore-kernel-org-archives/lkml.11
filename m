Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2679DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 18:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348944AbiEJSaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 14:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348885AbiEJSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:30:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7561573B;
        Tue, 10 May 2022 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652207445; x=1683743445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7k1HLML8EiHrtt/rP2Re4XQ7J53RxaR/YSDTSazTTZk=;
  b=Zbb2wA6vwfQHib7wqPf7Ddyln6BvCkRHc5CHbrvTKHVI+G9lZE4v9DAS
   lvJEPr6Y7tFDQX4TZtcSlAGoHGQzZiqprhghME3xbFEGFuU5wIkEPzWL8
   3hsM+gaIc7a40vAN/9K5Ty4PQEgK8FZ520Z8vSd+7ayUA72Gtu4nKZ0SQ
   UPRidi0gj/PuERAAlJXZ4zEHUPZe2RWTu6/+KtNzxv0DY/9hkMOSIp/M8
   WKeuQ6j5HYa+RG0x3ltEsHAb85P1NUf3cK74xfZZXv1R0pJD2zE1UHq29
   zNX3fNmLwB1nRaoHugElkFdDsZ5PPhyqZRXcmeNl0iCnvVK0xCXJbKVYw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249998290"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="249998290"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:30:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="738839903"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:30:43 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: intel: add binding for Intel n6000
Date:   Tue, 10 May 2022 11:30:40 -0700
Message-Id: <20220510183041.876583-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510183041.876583-1-matthew.gerlach@linux.intel.com>
References: <20220510183041.876583-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add the binding string for the Agilex based Intel n6000 board.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3:
  - added Acked-by
---
 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index 6e043459fcd5..61a454a40e87 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -18,6 +18,7 @@ properties:
         items:
           - enum:
               - intel,n5x-socdk
+              - intel,socfpga-agilex-n6000
               - intel,socfpga-agilex-socdk
           - const: intel,socfpga-agilex
 
-- 
2.25.1

