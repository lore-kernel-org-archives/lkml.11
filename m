Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4AAC43217
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 01:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbiBHBDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbiBGXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:03:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53E7C06109E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275008; x=1675811008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=plQnU2Dc8OE22hr3S5V59pRVLYmGY5GOp2NaA2zkwW8=;
  b=Z4S+LZSxcLCwQ72ADp+UrqTAn4RsTuAKdhTw9/qEaGf4OGTFeNg50J4g
   5H02OEdZcJqoWTA0jYjtm2vLZtMr9IpPXUuo9DVHYKLuevRbYR9Ekiy7X
   7fUL1UjwFmF8eARNVMap4hBDYxddIjHoBMFSLwrTfBEpw6RXjXNH2vZXj
   AP4y2Ns2GN4BYRsncxBxdA9Dqz3OBVyLXn1MVkQR+vLNKznvMH2qQCU0L
   RKXTbOnTkYYiB+NOd6EhvAupUfbfFytD7XcTeCn8cQWLmFhjx3j7BHIeD
   fbfeZSE+bIeuXdlTOVO4EWyawg2QLFbqzCfFwf8vd+hjH7aWYJhOV/SmJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229475009"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229475009"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540324030"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:02 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 03/11] iommu/ioasid: Introduce a helper to check for valid PASIDs
Date:   Mon,  7 Feb 2022 15:02:46 -0800
Message-Id: <20220207230254.3342514-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207230254.3342514-1-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pasid_valid() is defined to check if a given PASID is valid.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

v2:
- Define a helper pasid_valid() (Ashok, Jacob, Thomas, Tony)

 include/linux/ioasid.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e9dacd4b9f6b..2237f64dbaae 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -41,6 +41,10 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return ioasid != INVALID_IOASID;
+}
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -78,5 +82,10 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return false;
+}
+
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.35.1

