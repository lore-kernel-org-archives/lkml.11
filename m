Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDABC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 11:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349837AbiCXLjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiCXLjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 049611118
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648121882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2fN+Hv6TsPbRPdDuUO5SidGd4lpph9pjvvo58NSYRc=;
        b=HC8zph8Zwl7McQrQ6t6UX+QeJ0DfCssWjwx5A5VeYf/m3iqUa8ejrJsj6T4E/q9F5lQyXJ
        Rs2bQjLsE724/z9lYGE4hy81J4bFZMWZleJ+bqpvIM91cJzl2kin0PqZUnkFqRkyuylrT5
        2zw1fMFyVmqrOCcBr+NU+AzSP6Sk2qg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-irP0918XOmKEKNFA1xs28g-1; Thu, 24 Mar 2022 07:37:58 -0400
X-MC-Unique: irP0918XOmKEKNFA1xs28g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DB87899EE9;
        Thu, 24 Mar 2022 11:37:58 +0000 (UTC)
Received: from starship (unknown [10.40.194.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52DF12024CB6;
        Thu, 24 Mar 2022 11:37:56 +0000 (UTC)
Message-ID: <8da749c7fec55633e4c65f38a00040afbb22f85a.camel@redhat.com>
Subject: Re: [RFCv2 PATCH 06/12] KVM: SVM: Do not update logical APIC ID
 table when in x2APIC mode
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, joro@8bytes.org,
        jon.grimm@amd.com, wei.huang2@amd.com, terry.bowman@amd.com
Date:   Thu, 24 Mar 2022 13:37:55 +0200
In-Reply-To: <20220308163926.563994-7-suravee.suthikulpanit@amd.com>
References: <20220308163926.563994-1-suravee.suthikulpanit@amd.com>
         <20220308163926.563994-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-08 at 10:39 -0600, Suravee Suthikulpanit wrote:
> In X2APIC mode the Logical Destination Register is read-only,
> which provides a fixed mapping between the logical and physical
> APIC IDs. Therefore, there is no Logical APIC ID table in X2AVIC
> and the processor uses the X2APIC ID in the backing page to create
> a vCPU’s logical ID. Also, when x2AVIC is activated, a guest write
> to the x2APIC LDR register would result in #GP injection into
> the guest by the hardware.
> 
> Therefore, add logic to check x2APIC mode before updating logical
> APIC ID table.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm/avic.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 5329b93dc4cd..4d7a8743196e 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -406,6 +406,10 @@ static int avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
>  	bool flat;
>  	u32 *entry, new_entry;
>  
> +	/* Note: x2AVIC does not use logical APIC ID table */
> +	if (apic_x2apic_mode(vcpu->arch.apic))
> +		return 0;
> +
>  	flat = kvm_lapic_get_reg(vcpu->arch.apic, APIC_DFR) == APIC_DFR_FLAT;
>  	entry = avic_get_logical_id_entry(vcpu, ldr, flat);
>  	if (!entry)
> @@ -424,8 +428,13 @@ static void avic_invalidate_logical_id_entry(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	bool flat = svm->dfr_reg == APIC_DFR_FLAT;
> -	u32 *entry = avic_get_logical_id_entry(vcpu, svm->ldr_reg, flat);
> +	u32 *entry;
> +
> +	/* Note: x2AVIC does not use logical APIC ID table */
> +	if (apic_x2apic_mode(vcpu->arch.apic))
> +		return;
>  
> +	entry = avic_get_logical_id_entry(vcpu, svm->ldr_reg, flat);
>  	if (entry)
>  		clear_bit(AVIC_LOGICAL_ID_ENTRY_VALID_BIT, (unsigned long *)entry);
>  }

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

