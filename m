Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A8C2BA4C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jan 2022 23:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842488AbiAXXB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jan 2022 18:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457394AbiAXVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:55:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E34C07E296
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:36:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643056560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkeR8sx1uJfYl5V+1hDn7Z+OR1HYkHbw79HjnsAp4QY=;
        b=nkPJpLA2yOi+yzdNLC/2FWxejeY1zVZkgybDhWNcCuaClcSm2bzt7VcV1MQvPYNqFSo4+Q
        WHwstVrTl643QT6MMv2QwtlaHQ2QmQUyVTOX0A5i+DLaM0QGE/hv87T5+M9VjRhmijVtvs
        mud10TcJ3WSiYPn0nSuSprneTlnF/PRe/QB6adeMkUmsWnmel/Ig8eO53OIIH8ZrRvc8W7
        5l1g8VRInKtciwBJEh0eV8qVpDD4jfWXXCHTsS6Jt3B0iPNU2lurEpfjlNCv30gyTiIDlR
        vBV8TAKvfJcZ6G99jgEuC0BxiV0Da5jFhMfB7VozCkSDOqizG5z5xp5/oVk3Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643056560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkeR8sx1uJfYl5V+1hDn7Z+OR1HYkHbw79HjnsAp4QY=;
        b=h4ZLp5bKuVRuCYbVfeAOg6IS9CjOLBsFAmTC0ad9+KDBLUtxmYqHYPptNWjZhlF6uk2VLc
        bdMceZqau2ihH1BQ==
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <87ee4w6g1n.ffs@tglx>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com> <87ee4w6g1n.ffs@tglx>
Date:   Mon, 24 Jan 2022 21:36:00 +0100
Message-ID: <87bl006fdb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 21:21, Thomas Gleixner wrote:
>
> Hrm. This is odd.
>
>> +/* Associate a PASID with an mm_struct: */
>> +static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid)
>> +{
>> +	mm->pasid = pasid;
>> +}
>
> This does not get anything. It sets the allocated PASID in the mm. The
> refcount on the PASID was already taken by the allocation. So this
> should be mm_pasid_set() or mm_pasid_install(), right?

And as a result of all this ioasid_get() is now left without users...

Thanks,

        tglx
