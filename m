Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E078C25B0C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbiHIOy1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbiHIOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9836E1D0FB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660056863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=XDTKpeQgzL6QqSJ/Rvcc2aBgRFzttY4vWdPHNe6bWd3GHPh86sseBrbMLgBEGVuWcB9XgM
        sFUXcrJg/puNEVdUNaCRZC8ZNHvyJHgCZGhk5GbUUVIL4R4IuT3NvT8ScSRr5tca6bUhZN
        di8TIevQASne1S4f3iNnA4ECCXcFTNg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-eNGG5nXaPhuZkEAjRcFSBw-1; Tue, 09 Aug 2022 10:54:19 -0400
X-MC-Unique: eNGG5nXaPhuZkEAjRcFSBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44E6580418F;
        Tue,  9 Aug 2022 14:54:19 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F6EC2166B26;
        Tue,  9 Aug 2022 14:54:19 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Add sanity check that MMIO SPTE mask doesn't overlap gen
Date:   Tue,  9 Aug 2022 10:51:17 -0400
Message-Id: <20220809145117.122052-1-pbonzini@redhat.com>
In-Reply-To: <20220805194133.86299-1-seanjc@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


