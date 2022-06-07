Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D7C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 20:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376887AbiFGUsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 16:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356971AbiFGTq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:46:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946355EDCD;
        Tue,  7 Jun 2022 11:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC8A160DDE;
        Tue,  7 Jun 2022 18:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C351AC385A5;
        Tue,  7 Jun 2022 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654625923;
        bh=dLL/mOAB4T3gsc0LMPrI/8vzxFAxEm2zNTvqPqGxrqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GO8VY6AZS921R1cA7EvIllibSHZz6me/wxUbDwNKpXAjTD4qpsKR9rA8G7wuDmU8+
         kHkC2XgWdU8hZjojTk+1L3+KC4H82jd1Mjq89ccZg6RU4ghZAxw/RVCBAwmidqcvwW
         dRlyI8OJpjtg8pjZ3KUDofsvOfx/TvHIKik+3xmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 166/772] ACPI: CPPC: Assume no transition latency if no PCCT
Date:   Tue,  7 Jun 2022 18:55:58 +0200
Message-Id: <20220607164953.932028578@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Gondois <Pierre.Gondois@arm.com>

[ Upstream commit 6380b7b2b29da9d9c5ab2d4a265901cd93ba3696 ]

The transition_delay_us (struct cpufreq_policy) is currently defined
as:
  Preferred average time interval between consecutive invocations of
  the driver to set the frequency for this policy.  To be set by the
  scaling driver (0, which is the default, means no preference).
The transition_latency represents the amount of time necessary for a
CPU to change its frequency.

A PCCT table advertises mutliple values:
- pcc_nominal: Expected latency to process a command, in microseconds
- pcc_mpar: The maximum number of periodic requests that the subspace
  channel can support, reported in commands per minute. 0 indicates no
  limitation.
- pcc_mrtt: The minimum amount of time that OSPM must wait after the
  completion of a command before issuing the next command,
  in microseconds.
cppc_get_transition_latency() allows to get the max of them.

commit d4f3388afd48 ("cpufreq / CPPC: Set platform specific
transition_delay_us") allows to select transition_delay_us based on
the platform, and fallbacks to cppc_get_transition_latency()
otherwise.

If _CPC objects are not using PCC channels (no PPCT table), the
transition_delay_us is set to CPUFREQ_ETERNAL, leading to really long
periods between frequency updates (~4s).

If the desired_reg, where performance requests are written, is in
SystemMemory or SystemIo ACPI address space, there is no delay
in requests. So return 0 instead of CPUFREQ_ETERNAL, leading to
transition_delay_us being set to LATENCY_MULTIPLIER us (1000 us).

This patch also adds two macros to check the address spaces.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 123e98a765de..a7facd4b4ca8 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -100,6 +100,16 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 				(cpc)->cpc_entry.reg.space_id ==	\
 				ACPI_ADR_SPACE_PLATFORM_COMM)
 
+/* Check if a CPC register is in SystemMemory */
+#define CPC_IN_SYSTEM_MEMORY(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&	\
+				(cpc)->cpc_entry.reg.space_id ==	\
+				ACPI_ADR_SPACE_SYSTEM_MEMORY)
+
+/* Check if a CPC register is in SystemIo */
+#define CPC_IN_SYSTEM_IO(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&	\
+				(cpc)->cpc_entry.reg.space_id ==	\
+				ACPI_ADR_SPACE_SYSTEM_IO)
+
 /* Evaluates to True if reg is a NULL register descriptor */
 #define IS_NULL_REG(reg) ((reg)->space_id ==  ACPI_ADR_SPACE_SYSTEM_MEMORY && \
 				(reg)->address == 0 &&			\
@@ -1441,6 +1451,9 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
  * transition latency for performance change requests. The closest we have
  * is the timing information from the PCCT tables which provides the info
  * on the number and frequency of PCC commands the platform can handle.
+ *
+ * If desired_reg is in the SystemMemory or SystemIo ACPI address space,
+ * then assume there is no latency.
  */
 unsigned int cppc_get_transition_latency(int cpu_num)
 {
@@ -1466,7 +1479,9 @@ unsigned int cppc_get_transition_latency(int cpu_num)
 		return CPUFREQ_ETERNAL;
 
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
-	if (!CPC_IN_PCC(desired_reg))
+	if (CPC_IN_SYSTEM_MEMORY(desired_reg) || CPC_IN_SYSTEM_IO(desired_reg))
+		return 0;
+	else if (!CPC_IN_PCC(desired_reg))
 		return CPUFREQ_ETERNAL;
 
 	if (pcc_ss_id < 0)
-- 
2.35.1



