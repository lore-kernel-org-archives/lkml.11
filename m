Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B49C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 07:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbiEFHa4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 03:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbiEFHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:30:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D3766F97
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:27:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651822030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xakABXFY9Z5z2nqAlfMNh0e6jCaMQ4odsl0rcH2ghzQ=;
        b=W2dKLfnEOSERd1apR9HtgE9ASNwL7y+lAkClkWOgX2Lhp+lylULGJ5BSRl9lZ99M7Qy1BH
        9fU6WotLcCssSQqmVJ+wsQhgM+QwR+LfbwZQXY+GQqEb6x549J6rDVaSXlCQ7ty68cciQJ
        Z1w/l/Cdr6DcXK5BWGo0ScM7f7FM6pypWlNzNqRsPSjm3FTGhMfZJ8mCseDRQuVc0zu1KD
        uUe4tGMIyQeijEkxoVQxh8R7ec3GO3zMdB33AcdkVGcFqpZzKartMbEqeMkUWRELnYCcsS
        u7DueCrDCjtKj3GNC6gcqhJg9disisP5x3AMDUTOyBmqJFpZuAkSUv2jQBEqIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651822030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xakABXFY9Z5z2nqAlfMNh0e6jCaMQ4odsl0rcH2ghzQ=;
        b=T7Hx4WW++4BYEa5AE2IMsUVWNGTKjEe0DfVfmMlSOrMEthSd3yPV3kP8nvn0ehU1YKtlDG
        EAiOLVB6C2oUrGBA==
To:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] iommu/sva: Fix PASID use-after-free issue
In-Reply-To: <da5eafcc-1cb0-07fc-aa0d-0dccb8b8875a@linaro.org>
References: <20220428180041.806809-1-fenghua.yu@intel.com>
 <8f50c673-fe92-3c42-993d-43e65fc7235c@linaro.org>
 <da5eafcc-1cb0-07fc-aa0d-0dccb8b8875a@linaro.org>
Date:   Fri, 06 May 2022 09:27:09 +0200
Message-ID: <875ymji0j6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06 2022 at 09:49, Zhangfei Gao wrote:
> Will this be taken for 5.18?

It's queued in tip core/urgent and will go to Linus this week.

