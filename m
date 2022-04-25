Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BADC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 13:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbiDYNNt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbiDYNNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:13:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9535DDD;
        Mon, 25 Apr 2022 06:10:41 -0700 (PDT)
Date:   Mon, 25 Apr 2022 13:10:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650892239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6OEk80/8t8W77Fvu9cYNwGY2Q8QgDDy8rTXTFzVbjg=;
        b=S2+6Z/2Oln7/6B+ToKRvK+cpfwPvYYbUUTBkNDigeXwadiufBHR4yaX2mmMGEv9kPzmGqR
        X3mxxQHIvodsd//5HXmusQQo36opt8R+FdOFxe88vlLAt9OIKlooytgq4A4xiPln8vDUrB
        8IgZz9OZ6LEF8XLQGfNXUM8D66Aig8JeqielezFQT4T7k+gZqstDU2LStHEKD5Op24iKom
        IPl//3MWiRnthQQzzOUGcm2cr9ja695ly1MAdM4CGun8AEA5jckfpb59jwJ294Z+fVEFz9
        PPDPkJtIRrYlHsPwFTxKT4IBVmzJ1ZHP0YaMVYaV3U5hcJIg1XCUYzdGMeGWEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650892239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6OEk80/8t8W77Fvu9cYNwGY2Q8QgDDy8rTXTFzVbjg=;
        b=LM4aUtQK/T/XQcFyKImxXQUELg8mgKRPIyi3ZYeqi30fhy9ijmogNilsnkMvlzpMh78xSz
        AaDMIDQjPA3quMCg==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/matrix: Remove redundant assignment to variable 'end'
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220422110418.1264778-1-colin.i.king@gmail.com>
References: <20220422110418.1264778-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Message-ID: <165089223820.4207.15088483701554526670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1adb4d7ad3a585b451f5cf6b0a90c5917af3eac5
Gitweb:        https://git.kernel.org/tip/1adb4d7ad3a585b451f5cf6b0a90c5917af3eac5
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Fri, 22 Apr 2022 12:04:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Apr 2022 15:02:57 +02:00

genirq/matrix: Remove redundant assignment to variable 'end'

Variable end is being initialized with a value that is never read, it
is being re-assigned later with the same value. The initialization is
redundant and can be removed.

Cleans up clang scan build warning:
kernel/irq/matrix.c:289:25: warning: Value stored to 'end' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tom Rix <trix@redhat.com>
Link: https://lore.kernel.org/r/20220422110418.1264778-1-colin.i.king@gmail.com

---
 kernel/irq/matrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index bbfb264..1698e77 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -286,7 +286,7 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 			     unsigned int *mapped_cpu)
 {
-	unsigned int bit, cpu, end = m->alloc_end;
+	unsigned int bit, cpu, end;
 	struct cpumap *cm;
 
 	if (cpumask_empty(msk))
