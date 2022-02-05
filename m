Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAA0C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Feb 2022 00:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378610AbiBEABD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 19:01:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349219AbiBEAA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:00:59 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644019257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ri16KQqpRWhbQ9tq4lko5fBCxFjiFeJpIxcy6locFBk=;
        b=0PiJFv7Q680b0JcJbCwMzoad2gdGuTL+FEqbch9DbiWYQpYC2RzJNQNZR0SEHAWbcpWtmO
        IsEKaNIqVJkah7KNUzl6GTQEN1yhBz0iUDGC0vcmRFKWlSC9VqpPkwrNper5XEnHb/DJjP
        SrCKUni1xCDY7UJy5ocH+9qVsezO30/BSCQi9+xujys3Fu1qdbgeEBpxfYLDbWcjcS0q5h
        TLHfIA47v3BmLAAOzaTPM4sjfMhDFmqOM7aq+4XoMLkGE9v1KKvMlM26Q34aw64G5cVqj2
        YXsJGTku0kJ8hDRdf9JHBDEB5XaM7ST+Y+tpO3YWt6A8XJADAwbXZDt3F0lGzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644019257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ri16KQqpRWhbQ9tq4lko5fBCxFjiFeJpIxcy6locFBk=;
        b=+I+5521Op1f9Yh9qCYj91UeFSGP9ApszIdo7Uvfz1nweusNn4smNTrk9mfSMbAIRL/ua3G
        rqoCTiOrXMQ9rHCA==
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v3 09/11] x86/cpufeatures: Re-enable ENQCMD
In-Reply-To: <20220128202905.2274672-10-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-10-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 01:00:56 +0100
Message-ID: <87fsoyb2rr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2022 at 12:29, Fenghua Yu wrote:
> Since ENQCMD is handled by #GP fix up, it can be re-enabled.
>
> The ENQCMD feature can only be used if CONFIG_INTEL_IOMMU_SVM is set. Add
> X86_FEATURE_ENQCMD to the disabled features mask as appropriate so that
> cpu_feature_enabled() can be used to check the feature.
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
