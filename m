Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6505C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 23:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378148AbiBDX6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiBDX6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:58:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F0DF2F21A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:58:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644019084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDUgGvPWMNxmg2HvcMDEAADqZvuC4VFiJbMRtkkU6yU=;
        b=RTm144nrItzK5gVvN4SlRdwRBpFuwmP4ir2AFN7aMAUzUoxtZ4J1IfibRQkWXL1x/1XeBy
        kx62E1xpDFJU5ILdSi8FZT6RjIJOAPYJ9ur3tHbr4zliklQ1hMRN6RKoyPOx5t+HQxlnCL
        EzvULcsaW0Mq5XHkjcjDY4AIadS6N8sya+J2F9ZpkAYC2i8AMQp0W0PaZFQoD8EM963u4c
        kPEhpUEuWV9BQfcViZMW1nztFA3GTi81d2vHnuVI+4a9L9jPxtmfLiuuUEfSBfWIS5+eA2
        kxGQs8JXZmXy/wWXBu1cIw+KuZIwi89w3F339KkAQqpJV8S87euavC8RgNiiig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644019084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDUgGvPWMNxmg2HvcMDEAADqZvuC4VFiJbMRtkkU6yU=;
        b=K6a7Pf5YoQZ7npwp7mM2scULcd88DL8rKFi61Z6S0HJZkRzsO6OosUQ8kjU80G1YYGgqaE
        enHHul/Mf3RecjDA==
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
Subject: Re: [PATCH v3 06/11] x86/fpu: Clear PASID when copying fpstate
In-Reply-To: <20220128202905.2274672-7-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-7-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 00:58:03 +0100
Message-ID: <87o83mb2wk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2022 at 12:29, Fenghua Yu wrote:
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
