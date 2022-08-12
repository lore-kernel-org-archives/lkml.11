Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8735C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 07:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiHLH6N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbiHLH6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDA73A74F1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660291084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=OeEXGokUzRFjdnetH+u8n6vvtP5DtQ2nE4XY5l4tz3O1+axqI7UfVGMPcf1OjM5TeUAObV
        RdOP+uxMLLa06hpl/KLCtkImJLeRXisolKOwCQ+81ZYDHJNqtpGZK3JFSUQ/YIPc9itZIp
        9J0nUVhM90nEeakmTHlgk3T8hYGTJ4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-PeT3p9eYMt6n7y6obxaLKQ-1; Fri, 12 Aug 2022 03:58:01 -0400
X-MC-Unique: PeT3p9eYMt6n7y6obxaLKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C3838032E3;
        Fri, 12 Aug 2022 07:58:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBAFDC15BA8;
        Fri, 12 Aug 2022 07:58:00 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oupton@google.com>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 0/2] KVM: selftests: Fix Clang build issues in KVM_ASM_SAFE()
Date:   Fri, 12 Aug 2022 03:57:58 -0400
Message-Id: <166029101189.410868.1013034335296183657.b4-ty@redhat.com>
In-Reply-To: <20220722234838.2160385-1-dmatlack@google.com>
References: <20220722234838.2160385-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo

