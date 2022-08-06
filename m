Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED486C19F2D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Aug 2022 12:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiHFM1Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Aug 2022 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiHFM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:27:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E687411168
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659788839; x=1691324839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PJsGoT+j4Bs8ncLa5K0pAkQgOVnmbbiPh2T9DtQ2FhI=;
  b=Lz8OwGylQnGNnIvLG4P41kZlGZi28RvyoYET/UMvJqVdavBqDV94SDqd
   jMwe3qR5l7xI3jZ+d3SjbYbHzJFG19b40s8hhSYoN9NIN0Ws5wl3sLV+l
   qP5uAp/gtJ88DITEG1n/4rZXHB0AovIMPPXAx3YY/LvOzylXPMV6C6bZ2
   3+PNjfAlmNTrwf6zXvLj3id3ENPLgwBFxeViyKV2ZBckjIzS5UgYKPgIr
   u034FYE4kl/uzTM/3HfctOcMN5pgQ+yqivDp/C1B144VN7h0y96u1naDf
   0dUsn6sVCq1M6svETgnU5bQ1r4mHfozMEqjUi9vKK97i2pQweNeNPLB1W
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289121875"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289121875"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="632329036"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:16 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
Subject: [PATCH v7 02/15] mei: add kdoc for struct mei_aux_device
Date:   Sat,  6 Aug 2022 15:26:23 +0300
Message-Id: <20220806122636.43068-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806122636.43068-1-tomas.winkler@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mei_aux_device is an interface structure
requires proper documenation.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 include/linux/mei_aux.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
index 587f25128848..a0cb587006d5 100644
--- a/include/linux/mei_aux.h
+++ b/include/linux/mei_aux.h
@@ -7,6 +7,12 @@
 
 #include <linux/auxiliary_bus.h>
 
+/**
+ * struct mei_aux_device - mei auxiliary device
+ * @aux_dev: - auxiliary device object
+ * @irq: interrupt driving the mei auxiliary device
+ * @bar: mmio resource bar reserved to mei auxiliary device
+ */
 struct mei_aux_device {
 	struct auxiliary_device aux_dev;
 	int irq;
-- 
2.37.1

