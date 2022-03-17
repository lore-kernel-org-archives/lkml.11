Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11378C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 12:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiCQMrs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiCQMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:47:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89CF105074
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:46:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647521189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6UWSnFJfyk89o7rv8EPIFwEm6EdPuHp5eJF4BxTz6A8=;
        b=mjxI6T6gLnySTe1LlKvUeulr1uJ4VHy0kpoQCCrtNohrfOd6vplkmnchXxeYzaJbtodgZN
        gIP61eEs4VbeI3SDPMFEVhUSeysggJjrmZDzxABjL+bnlEqHUMCwdG7blMtNg+oMtU9IoQ
        cgV+SqrCHUBwBDcen/Z6CpDV6iSjkOaIpmlO6fsw0iPmpMY/qFBZt1ZZQsiomlVWaKtwCA
        HGlRrB35F/iL+0AS9VLSt6zDaasJTQNe9JoiTooLXDkMZfICc3xIA43CRyaD4fEgwL6+iH
        /aZNOywuZX7wUm79urqpekgHgNVotd1o+SgphkCgXEUBt9g41BiHgzpdC0wbag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647521189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6UWSnFJfyk89o7rv8EPIFwEm6EdPuHp5eJF4BxTz6A8=;
        b=4BgG7RPsmYMViCMUP1fWipHpMA9zfS8Rc4HcliVU1B6LyhfbBa5IWLMv6o2KFb03/dQtni
        CDXY1s+CnmVyHsDA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 22/30] x86/boot: Set CR0.NE early and keep it set
 during the boot
In-Reply-To: <20220316020856.24435-23-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-23-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 13:46:29 +0100
Message-ID: <87wngszqze.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> Make CR0 initialization consistent, deriving the initial value of CR0
> from CR0_STATE. Since CR0_STATE always has CR0.NE=1, this ensures that
> CR0.NE is never 0 and avoids the #GP.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
