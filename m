Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E498C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 23:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244345AbiECXoh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 19:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiECXog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C0742491
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE5AF617DE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED7FC385A9;
        Tue,  3 May 2022 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651621261;
        bh=+tezogTSV04DoRfNPTRO1bdR//3Y4tWK1IjFnVw7LlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgBnQAlcsxpLon6CBN+YbHbw7TNsR772LOJU85BHBpbn6ULL3OPFvfMTyUjR1hXjt
         ZGL9kC1YyNCAOR6R82CHjuwMAwnpq3RIyUh5NFO1X3PAjFImVFO4ezBcU4rnUDARPs
         bWAv/knGIJpwf/8er52TRA75TLdEXy67v6MtvmGlRmWKPKhQosFswaQsPC+t70FxxM
         yyGWd0MZ1ly8BVxl4qMWQV3/Xh8IXLl/LHAp/adtQZuMVrgopFsqtcXwIhZnKq4l+w
         uYutrsI62HfILf4oCoMDeugPNgFGzUHusWE/YfEdPeMQdMeWVLMGIa8MFeJ3FjOmTZ
         /VKXf8Ls4jGpg==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, sj@kernel.org,
        damon@lists.linux.dev
Subject: Re: [PATCH v8 16/70] damon: Convert __damon_va_three_regions to use the VMA iterator
Date:   Tue,  3 May 2022 23:40:57 +0000
Message-Id: <20220503234057.105810-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426150616.3937571-17-Liam.Howlett@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,


Could you please add I and damon@lists.linux.dev to the recipients of this
patch from next time?

On Tue, 26 Apr 2022 15:06:32 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> This rather specialised walk can use the VMA iterator.  If this proves to
> be too slow, we can write a custom routine to find the two largest gaps,
> but it will be somewhat complicated, so let's see if we need it first.
> 
> Update the kunit test case to use the maple tree.  This also fixes an
> issue with the kunit testcase not adding the last VMA to the list.
> 
> Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
