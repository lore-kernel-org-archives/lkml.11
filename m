Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0BEC4332F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiDEIGw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiDEHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:54:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9320184;
        Tue,  5 Apr 2022 00:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B28A161725;
        Tue,  5 Apr 2022 07:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83EEC340EE;
        Tue,  5 Apr 2022 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649144962;
        bh=1JZcWH0YBYn6eQesTkcl7qH/m6/S96+irj0tPNNYQS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrxlExU5QBKN6MY8xlQHjeEPzS3IWbf2y78M/zG0CoZhSlpJuECcYI4lXgXoE+RKA
         2VMKUhMetBKWtGiT0rI3ZMh2H6eGBUoE9jzdFPYG0MU66woS0KC/hQoTru0pNu0fDb
         kP0p7di2rMu6r1ObYfGrghiniHsrCdi/fnKQVvB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0217/1126] selftests/sgx: Do not attempt enclave build without valid enclave
Date:   Tue,  5 Apr 2022 09:16:04 +0200
Message-Id: <20220405070413.979360900@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

[ Upstream commit fff36bcbfde1126f6b81cb8ee12a58aada17ca29 ]

It is not possible to build an enclave if it was not possible to load
the binary from which it should be constructed. Do not attempt
to make further progress but instead return with failure. A
"return false" from setup_test_encl() is expected to trip an
ASSERT_TRUE() and abort the rest of the test.

Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lkml.kernel.org/r/e3778c77f95e6dca348c732b12f155051d2899b4.1644355600.git.reinette.chatre@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sgx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 370c4995f7c4..a7cd2c3e6f7e 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -147,6 +147,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	if (!encl_load("test_encl.elf", encl, heap_size)) {
 		encl_delete(encl);
 		TH_LOG("Failed to load the test enclave.\n");
+		return false;
 	}
 
 	if (!encl_measure(encl))
-- 
2.34.1



