Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810FFC00140
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Aug 2022 11:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiHELRW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Aug 2022 07:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHELRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8998417A8F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659698238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=FIQQyQMEAsOWLvIGzAbbvEjFQfPZd5eSUCefghC7UrOEu5JngiygVl0T6OSXD8D7VG4mO1
        /8BBUVGQgzLWSYWRpEAK6BGEQ+UfAoscaRaYFoLwai0FGmoc6RirdrpVHmGAbRznUw/haV
        DdsJ4Key3BHKcGVeXQhBLxTS3T5cI8s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-FaJGjcO_OzyZLoIQnp8_ow-1; Fri, 05 Aug 2022 07:17:13 -0400
X-MC-Unique: FaJGjcO_OzyZLoIQnp8_ow-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14C7785A585;
        Fri,  5 Aug 2022 11:17:13 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C24E5492CA2;
        Fri,  5 Aug 2022 11:17:12 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 0/3] KVM: x86/mmu: MMIO caching bug fixes
Date:   Fri,  5 Aug 2022 07:17:06 -0400
Message-Id: <20220805111706.1431548-1-pbonzini@redhat.com>
In-Reply-To: <20220803224957.1285926-1-seanjc@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


