Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 12:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbiBYMEW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 07:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiBYMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22FB41B84D5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645790620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=DX9JkzmO4tBvYcW1HNPffJm4iyH5cciX+SXmbGMfr1NB5VBvuqhX6me/YjjpP6OIeBwHCG
        VpwSKvy3Ci0UJYSVZDCeIdEcp+lMBlNJE6eCq89XLD8OloXNzMrRt3xZMdMUxN2gm1YgeD
        wu34xjrPrJtNB5qDPunLPYArYZhyaSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-J0n2rnBTO3aOgL-ZGXZvwA-1; Fri, 25 Feb 2022 07:03:37 -0500
X-MC-Unique: J0n2rnBTO3aOgL-ZGXZvwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 930CB801AAD;
        Fri, 25 Feb 2022 12:03:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41EC11038ADB;
        Fri, 25 Feb 2022 12:03:27 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, kvm@vger.kernel.org, wei.liu@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, Andrea.Parri@microsoft.com,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH] x86/kvmclock: Fix Hyper-V Isolated VM's boot issue when vCPUs > 64
Date:   Fri, 25 Feb 2022 07:02:44 -0500
Message-Id: <20220225120243.2387649-1-pbonzini@redhat.com>
In-Reply-To: 20220225084600.17817-1-decui@microsoft.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


