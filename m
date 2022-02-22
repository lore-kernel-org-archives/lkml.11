Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8C7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 22:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiBVWik (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 17:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiBVWij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:38:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F65123400
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:38:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D6CCCE13A9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E39EC340E8;
        Tue, 22 Feb 2022 22:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645569489;
        bh=gvAAeLf847z7axEoDRaQ+MvtM7+m4/D/kVnYvQLGmwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLm7nloVEnwTfTEpI0hKv9MuXo85nojgGZt0AFJqP4rnUSAXlriq+dttXwXrJJmpW
         dAgwbXdotYbF7VZqDMLIgoiAbCxu/A1wWWrGdDyIC4UglSIql3sT2EHkGW0xPDlOov
         ChUcznxT2nnZQqUpADrGjRVOpdljL/zjdzQ9PcooyXcXU/AxHDstMxhNVQhEI9Gjh+
         OXaU/a4WzqwHX1k7eRgmEPYigx5KLOHEG8kyQLg12/AcoWwonBSRt6xkXg3JRkIx+O
         GwgE9T4QNC8UXY4yK6yEb9z39UBIn1Tb/BPQMLD/JLmtAPBTDWA1Q7ciuVHHRhItXE
         MbuLAXwKceG+w==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64/hugetlb: Define __hugetlb_valid_size()
Date:   Tue, 22 Feb 2022 22:38:01 +0000
Message-Id: <164556791444.740450.15251075686111265669.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1645073557-6150-1-git-send-email-anshuman.khandual@arm.com>
References: <1645073557-6150-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 10:22:37 +0530, Anshuman Khandual wrote:
> arch_hugetlb_valid_size() can be just factored out to create another helper
> to be used in arch_hugetlb_migration_supported() as well. This just defines
> __hugetlb_valid_size() for that purpose.
> 
> 

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/hugetlb: Define __hugetlb_valid_size()
      https://git.kernel.org/arm64/c/a8a733b20109

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
