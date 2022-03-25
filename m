Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B59AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 11:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353389AbiCYLDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353832AbiCYLC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A521C4E0E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648206084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=djp5XNqFQfJvL9jvcJIBR71HYiBGzr7Bef+oNNFSL3RayS1xJGYRc6n3SvhfUzqMZ42rWQ
        qWqi31U6SfpEiyg1x8Tn1881cblUBfT/uTeA2JnuoUEsrsKhnh0KD/2mAp5Ztx3CHiOq8X
        ivRiHIV2lwGeE9bq6qIf02p9BtLpwVs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-Tkd3vQDpNSWCXk7xQWt1eg-1; Fri, 25 Mar 2022 07:01:21 -0400
X-MC-Unique: Tkd3vQDpNSWCXk7xQWt1eg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EBA7899ED2;
        Fri, 25 Mar 2022 11:01:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C1152166BB3;
        Fri, 25 Mar 2022 11:01:06 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Jon Kohler <jon@nutanix.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: optimize PKU branching in kvm_load_{guest|host}_xsave_state
Date:   Fri, 25 Mar 2022 07:01:00 -0400
Message-Id: <20220325110100.2954008-1-pbonzini@redhat.com>
In-Reply-To: <20220324004439.6709-1-jon@nutanix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


