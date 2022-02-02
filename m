Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC7AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Feb 2022 19:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346963AbiBBTrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Feb 2022 14:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiBBTrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:47:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7671C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:47:39 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643831258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZoMxZzJu0S/zqcRHBoQiDF6946Gib9Z2JSpxFb9lqcU=;
        b=19/icYGJQiS5348IT4VwZu2g7WTaZchV1+AlxNtTqRusdinWD0Gk3hEaTZZCqlAPecL7Zq
        TrjdwfzdlhaKIjNCcOS1CQ+44vxg3szX9TVUGUy4DpLAeFtn6LVl4VEX+IyzFYiiVQCGsf
        3IAe8PPGDyI+Zik3IsecXxHCDk0AIQtaRd5vOgLD/8lIpOjSeOC5u6CtU19/o9k/PMXFEt
        F/mo2IHQRmmqY123EpQU3Tf4MeVj83ruZUpTpl2te+mt221HL0lQS1aZcf1xewpKqPkO+K
        QgxZSxBPheE3GTEDJ9uvbY1fXgzx3JbuLxlQE6NmWFVirEjEhQ6MWtWHIfFPxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643831258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZoMxZzJu0S/zqcRHBoQiDF6946Gib9Z2JSpxFb9lqcU=;
        b=JMHGuKF10zNs7Za6nG512D3d0fxafCKRCjHyK8Y0QvCO7oX/ZejP8IGoGGHliV2IVYUAjE
        mD7IW/G2/PVvfNAg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
In-Reply-To: <20220202192710.d7k4pgqczpyrkers@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <87bkzqw1vr.ffs@tglx> <20220202192710.d7k4pgqczpyrkers@black.fi.intel.com>
Date:   Wed, 02 Feb 2022 20:47:37 +0100
Message-ID: <877dadt5ie.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02 2022 at 22:27, Kirill A. Shutemov wrote:
> On Wed, Feb 02, 2022 at 01:25:28AM +0100, Thomas Gleixner wrote:
>> On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
>> I cannot find any of the above mentioned subsystems in this grep
>> output. Neither does this patch add any users which require those
>> exports.
>
> Try to grep pgprot_decrypted().

Bah.

> I guess we can get away not exporting pgprot_encrypted(), but this
> asymmetry bothers me :)

Well, no. We export only stuff which is needed. Exporting just because
is a NONO.

Thanks,

        tglx
