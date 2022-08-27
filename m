Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AB5ECAAD5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 01:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245063AbiH0BQD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 21:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbiH0BPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:15:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3367B780
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:15:51 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDzGv6jVKznTV0;
        Sat, 27 Aug 2022 09:13:27 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 09:15:48 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <tglx@linutronix.de>, <frederic@kernel.org>,
        <peterz@infradead.org>, <nitesh@redhat.com>,
        <bigeasy@linutronix.de>, <douliyangs@gmail.com>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <weiyongjun1@huawei.com>, <xuqiang36@huawei.com>
Subject: [PATCH -next 3/3] genirq/affinity: Add __irq_do_set_affinity_lock function.
Date:   Sat, 27 Aug 2022 01:13:51 +0000
Message-ID: <20220827011351.9185-3-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220827011351.9185-1-xuqiang36@huawei.com>
References: <20220827011351.9185-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make irq_do_set_affinity more concise and clear, force argument
is handled first, and then non-force scenarios are handled in
the __irq_do_set_affinity_lock function.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 kernel/irq/manage.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ae1c7eebdfa6..1fa8ef781736 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -209,21 +209,14 @@ static void irq_validate_effective_affinity(struct irq_data *data)
 static inline void irq_validate_effective_affinity(struct irq_data *data) { }
 #endif
 
-int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
-			bool force)
+static int __irq_do_set_affinity_lock(struct irq_data *data, const struct cpumask *mask)
 {
-	struct irq_desc *desc = irq_data_to_desc(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	const struct cpumask  *prog_mask;
 	int ret;
 
-	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
 	struct cpumask tmp_mask;
 
-	if (!chip || !chip->irq_set_affinity)
-		return -EINVAL;
-
-	raw_spin_lock(&tmp_mask_lock);
 	/*
 	 * If this is a managed interrupt and housekeeping is enabled on
 	 * it check whether the requested affinity mask intersects with
@@ -264,13 +257,31 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 * case we do as we are told).
 	 */
 	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
-	if (!force && !cpumask_empty(&tmp_mask))
-		ret = chip->irq_set_affinity(data, &tmp_mask, force);
-	else if (force)
-		ret = chip->irq_set_affinity(data, mask, force);
+	if (!cpumask_empty(&tmp_mask))
+		ret = chip->irq_set_affinity(data, &tmp_mask, false);
 	else
 		ret = -EINVAL;
 
+	return ret;
+}
+
+int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
+			bool force)
+{
+	struct irq_desc *desc = irq_data_to_desc(data);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	int ret;
+
+	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
+
+	if (!chip || !chip->irq_set_affinity)
+		return -EINVAL;
+
+	raw_spin_lock(&tmp_mask_lock);
+	if (force)
+		ret = chip->irq_set_affinity(data, mask, force);
+	else
+		ret = __irq_do_set_affinity_lock(data, mask);
 	raw_spin_unlock(&tmp_mask_lock);
 
 	switch (ret) {
-- 
2.17.1

