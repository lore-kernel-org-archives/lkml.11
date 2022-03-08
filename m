Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1726EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 19:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbiCHTQn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiCHTQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:16:41 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3564EA03
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:15:44 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v4so233772pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5tlumRnUSQglQq/+mWE9RjiXVXWEbK2EvGGExgddWkc=;
        b=sCQ3di/YdCWVkNgx6JQrLP5gl311dT7UwNR1xAyphg/768Pa0fjac5O5dEC5kHD4iG
         /yGiyocomy/THvBBttTG+I2bmD4D7Gyc6fUKUMNvY43Ac++TzvofyASIImW6wgdpzoRP
         KtZtPvC0gKKeqwWpGG4wjfULoSWtVc3Tey/Hk92FOrwoxMDDIt1mmF+ztcRycO+yxCUZ
         viOMzvuSKKWeJjJk/UMOPlvNntcGvkJg/JGdYoN3edN2l7TwxURMoLgcZjyH6UQ7X71C
         xssYwmFSXiEtw4h9zESlNQ9g41Ca/JZ2oLV3pvStaQo+zKFwq7zprW2Om+n5bu8ELxs7
         HF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5tlumRnUSQglQq/+mWE9RjiXVXWEbK2EvGGExgddWkc=;
        b=ZKfvdmIq+Kym6N/xA5WdfqSxn1J88kXM4BCba1lB2Wj99DJIx3E6lt1w2KkdApoNCJ
         Hr8SlXbR5h02dis4T487A20w3x+1txWqWv/nolnOrejtU0Q41TOlIqLb8q0LKMPHyf2x
         EMjDj0FwzFvDGQ653oU2VxMRKIi6Pgp4/x6XVkyx7CReyr8MUjg4RPRBa7h+T6QoD4Pz
         kiQ+M6rCQp65zQ2a08PnRQ9LbhtBYhRHY9yc3DrpVFuCgTBfihgug+tFzTOR2UpCRcqF
         lF6tGXz0H5CfoSokvb0vMnBEhoPvgaMqDwKviod8ueJt6/cTb5Ku+neDv2qsNauZotC4
         Qfpw==
X-Gm-Message-State: AOAM532U4Xk2F+vkzMPdvKCmPaBQhzeZVPo0aMxTEJT4T7vZ5V3bVkL+
        8TjuHbvXUx6hjsaTxCRhpr+JuxmrGpNxyQ==
X-Google-Smtp-Source: ABdhPJydNcfCwG0t9dztRqYGilmcV87Dl6j5Ro/inIEy5gYIF2PexhSqT1b9H/frSjYR1oh8Mj0sPQ==
X-Received: by 2002:a17:90b:3e8d:b0:1bf:4525:c834 with SMTP id rj13-20020a17090b3e8d00b001bf4525c834mr6294421pjb.63.1646766944234;
        Tue, 08 Mar 2022 11:15:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm21989018pfu.40.2022.03.08.11.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:15:43 -0800 (PST)
Date:   Tue, 8 Mar 2022 19:15:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 16/25] KVM: x86/mmu: rename kvm_mmu_role union
Message-ID: <YierXBEvTdp5aw+u@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-17-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> It is quite confusing that the "full" union is called kvm_mmu_role
> but is used for the "cpu_mode" field of struct kvm_mmu.  Rename it
> to kvm_mmu_paging_mode.

My official vote is to use

	union kvm_mmu_cpu_role cpu_role

instead of

	union kvm_mmu_paging_mode cpu_mode

The latter has too many inconsistencies, e.g. helpers using "role" instead of "mode",
the union using "paging" but the field/params using "cpu".  The cpu instead of paging
thing isn't a coincidence as having the param be "paging_mode" would be really, really
confusing (ditto for kvm_calc_paging_mode()).

IMO this is consistent, if imperfect.

static union kvm_mmu_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
						const struct kvm_mmu_role_regs *regs)
{
	union kvm_mmu_cpu_role role = {0};

	role.base.access = ACC_ALL;
	role.base.smm = is_smm(vcpu);
	role.base.guest_mode = is_guest_mode(vcpu);
	role.base.direct = !____is_cr0_pg(regs);

	role.ext.valid = 1;

	if (!____is_cr0_pg(regs))
		return role;

	...

	return role;
}

Whereas this is inconsistent, and also imperfect.

static union kvm_mmu_paging_mode kvm_calc_cpu_mode(struct kvm_vcpu *vcpu,
						   const struct kvm_mmu_role_regs *regs)
{
	union kvm_mmu_paging_mode role = {0};

	role.base.access = ACC_ALL;
	role.base.smm = is_smm(vcpu);
	role.base.guest_mode = is_guest_mode(vcpu);
	role.base.direct = !____is_cr0_pg(regs);

	role.ext.valid = 1;

	if (!____is_cr0_pg(regs))
		return role;

	...

	return role;
}
