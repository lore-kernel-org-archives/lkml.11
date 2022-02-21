Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF7EC43217
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352557AbiBUJrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:47:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350846AbiBUJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:40:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895E732EEE;
        Mon, 21 Feb 2022 01:17:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E81EFCE0E88;
        Mon, 21 Feb 2022 09:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8715C340E9;
        Mon, 21 Feb 2022 09:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435038;
        bh=jYwiTOzuxOogEwmmZu7c9TjY0pi0EyrysgTTXTM6OZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wp6DdanR5PfhX5M2ZSY018gKGChmh/qd35NEKSY/P4CXrCpZnxMmx2yVx06Xy993j
         YSxeHCP4ykEOvF/AQx0nBK/bDz1cGqqd6PYorDlRmiMD+CTDkavX4aZOmVLrm0xW9E
         5By53FY8wiptYYjUuuCYSYTo7G5FIovwj0V20Xwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.16 023/227] selftests: kvm: Remove absent target file
Date:   Mon, 21 Feb 2022 09:47:22 +0100
Message-Id: <20220221084935.613639074@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

commit 0316dbb9a017d3231f86e0188376f067ec26a59c upstream.

There is no vmx_pi_mmio_test file. Remove it to get rid of error while
creation of selftest archive:

rsync: [sender] link_stat "/kselftest/kvm/x86_64/vmx_pi_mmio_test" failed: No such file or directory (2)
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1333) [sender=3.2.3]

Fixes: 6a58150859fd ("selftest: KVM: Add intra host migration tests")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Message-Id: <20220210172352.1317554-1-usama.anjum@collabora.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/kvm/Makefile |    1 -
 1 file changed, 1 deletion(-)

--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -75,7 +75,6 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
-TEST_GEN_PROGS_x86_64 += x86_64/vmx_pi_mmio_test
 TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test


