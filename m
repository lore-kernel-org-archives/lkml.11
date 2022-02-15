Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6623C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 09:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiBOJzg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:55:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiBOJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:55:31 -0500
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0810A7FE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:55:22 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F22B836D; Tue, 15 Feb 2022 10:55:20 +0100 (CET)
Date:   Tue, 15 Feb 2022 10:55:19 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ygt4h0PgYzKOiB38@8bytes.org>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207230254.3342514-6-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 03:02:48PM -0800, Fenghua Yu wrote:
> PASIDs are process wide. It was attempted to use refcounted PASIDs to
> free them when the last thread drops the refcount. This turned out to
> be complex and error prone. Given the fact that the PASID space is 20
> bits, which allows up to 1M processes to have a PASID associated
> concurrently, PASID resource exhaustion is not a realistic concern.
> 
> Therefore it was decided to simplify the approach and stick with lazy
> on demand PASID allocation, but drop the eager free approach and make
> a allocated PASID lifetime bound to the life time of the process.
> 
> Get rid of the refcounting mechanisms and replace/rename the interfaces
> to reflect this new approach.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Acked-by: Joerg Roedel <jroedel@suse.de>

