Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632BEECAAD4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 10:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiH2KO6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 06:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiH2KOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:14:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D576026CC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mzt070IZSqr3xh0D3YKD5OYv4JJfQhgl4eWuS+wzyhw=; b=ShlYuiRsB7aiezhSLWaAfY9tG2
        PVXvBKov4Cozzug264Jzz1Mx57ODjPCpC2lYSGbVdq+x/OLxvFToUbAMU/pHEtlnONzGOrsh8R0z4
        mxPkNnDgi+ojUkvaMyIxsW0FLATZYp1EAua4epRHCTKwazodeRZSr5u7fj/Pyjq/EtRoe0bGRVd7d
        iMJtlc3usUT9r2TKK0NaulJF65jiPa4edVLdSnwYCUPjPxyveAU92veKInUQZw9X1jYE4LbEoLVH9
        haecZ/xQVZXNhTCDnz/fROgnD2SWGBFSNw/Om2NcJsgU2KVEHCjchyv5O7yeD4P+20Zc9xRRkI3Ug
        ND/r2bdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbn1-00304s-4j; Mon, 29 Aug 2022 10:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86C263002C7;
        Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 69D40203BFBC2; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Message-ID: <20220829100959.917169441@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Aug 2022 12:09:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH v2 0/9] perf/x86: Some cleanups
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found I still had these patches laying about. I dropped the removal of the
minimal period or 2 and there's a few extra patches since the first posting.

  https://lkml.kernel.org/r/20220511142037.353492804@infradead.org



