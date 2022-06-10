Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4803CC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 14:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349604AbiFJOeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349518AbiFJOd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:33:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FBC1567EE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:33:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so2446444pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PxR9OrMSrWpGfEqawpy3/wVuAkYaSeZlAnBh5KVMXJE=;
        b=NJbzSY3yJxO4M4StgBH/ADd+InJNwVt4O3UCjO1lmgKqqZoWakKAC4evwmHBWOT6DD
         ZXztB7rGawow2r4HA4er20ia0kLPCsu6l5vPb53g9jzV06R6FazDE00XpE4uBONTos35
         qpc+wlG9Ale+JvKoySfGLzKdmfZM/XSb9PomEoFCY4enp8ZUXSX0NMyJAB+WxM2+3sUk
         S6iFFlKOiNWC8b5gZJ+5p5+yKSbk+e1QjJpLpMZ15ikiAY91IrV5pzHCmN5B/gkn/aUf
         Mep+j/k2tWgjRuUV40mYcHHczhP8X+QCTXPVn9ZhnPz8A8g541OlmakI7DWfYvCl0o0F
         k2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PxR9OrMSrWpGfEqawpy3/wVuAkYaSeZlAnBh5KVMXJE=;
        b=BuVPx5zazyEAwU3Bb7VSleWJb8q+43H7xciRpsiZIygEgUDCf2gYZdpmsatC01NK8w
         9oSNTlbUhnd5FS1lXs0Bwc4WeLBxEEiLrjLTPgIsvunKDmX8D8l4ICr0C1rs1SSogbTV
         wyqQgZN/m/V5StYXhTLzPTLk+yoLlH/LDdKVQF1nlThKmyt1WT8B3FHYbYtObFznqlYt
         aqJdJwLO51Hl1zCCAwJ7qTV8vPUFsFoIVtiys2Xljkgw68IGyCKhRmabk4Hc7ENcLzsO
         8TK08oY75EDNMn/pLWbE151y9UIx+V26+ugIqyZ1iU4dPP1rScamF4pOUqHK0GjWssej
         OR6A==
X-Gm-Message-State: AOAM5328uA8dxcVXxmHe5f+2NrKTNhhnqbd6blU4e9OvCi7X0eJ3sMDP
        gNx/n3XLO7R+j+GE/+BcOqeY6Qfl9K2Bgw==
X-Google-Smtp-Source: ABdhPJz5794unjcLLHf76DTPX/t1FfZvxPtA+iJKJnZE7mgcdzh1ieHg0oZJuGEsiodfohqFec+KlQ==
X-Received: by 2002:a17:90b:3805:b0:1e6:85aa:51b with SMTP id mq5-20020a17090b380500b001e685aa051bmr70256pjb.182.1654871595529;
        Fri, 10 Jun 2022 07:33:15 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d9-20020a656b89000000b003fd7e217686sm11556105pgw.57.2022.06.10.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 07:33:14 -0700 (PDT)
Date:   Fri, 10 Jun 2022 14:33:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 126/144] KVM: selftests: Convert kvm_binary_stats_test
 away from vCPU IDs
Message-ID: <YqNWJwlGWleTw7sR@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-127-seanjc@google.com>
 <20220610104851.g2r6yzd6j22xod6m@gator>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610104851.g2r6yzd6j22xod6m@gator>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022, Andrew Jones wrote:
> On Fri, Jun 03, 2022 at 12:43:13AM +0000, Sean Christopherson wrote:
> > @@ -220,17 +221,21 @@ int main(int argc, char *argv[])
> >  	/* Create VMs and VCPUs */
> >  	vms = malloc(sizeof(vms[0]) * max_vm);
> >  	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
> > +
> > +	vcpus = malloc(sizeof(struct kvm_vcpu *) * max_vm * max_vcpu);
> > +	TEST_ASSERT(vcpus, "Allocate memory for storing vCPU pointers");
> > +
> >  	for (i = 0; i < max_vm; ++i) {
> >  		vms[i] = vm_create_barebones();
> >  		for (j = 0; j < max_vcpu; ++j)
> > -			__vm_vcpu_add(vms[i], j);
> > +			vcpus[j * max_vcpu + i] = __vm_vcpu_add(vms[i], j);
> 
> The expression for the index should be 'i * max_vcpu + j'. The swapped
> i,j usage isn't causing problems now because
> DEFAULT_NUM_VM == DEFAULT_NUM_VCPU, but that could change.

It's better to be lucky than good?

Thanks much, I appreciate the reviews!
