Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 14:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354600AbiDOOnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349869AbiDOOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:42:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB121A393
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:39:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so7272808plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1MnvIUTCnDUhW/MEcdcS6a3sJGad6CD8T1rW5EsHJho=;
        b=ERP9pfWyY6alNYGhD48Zx2tVKN4LFJdrCOxLl3DgrkY8Uoebc+mqvBHsJ0wNr0H91I
         iJlOikU9SuosDX3fezHVHtW/9TaCkdUJFWtppyap9e4ThipVFTS1UYRIF1XL63AJQ6+b
         N5kAbODQQoSrY0Igts9Vv2ptmwOLZ/rHvl13UotTUsYZoRv9hrSOSlg8l8CjvbdPj6Hk
         wzuOPlYgSwylW5rt+oE4SaY0RAhCm/vIuZKUTC90h3m1Wcg9a9tatSQwi3gEFM83zBr5
         oU1XixgbbeyUZH0/n//qIs8FGfjWlgqM3+cFfQ037bArt8Wct10TDXW2gRoAlx/opM55
         PLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MnvIUTCnDUhW/MEcdcS6a3sJGad6CD8T1rW5EsHJho=;
        b=mu8VKendGb8U+yH3TVpU2jYeNFk0YX5P6uHJ5f9nr5LG7Rqkpr7FaIubKYzZvrKR16
         lfgRjFi+8WDUVXUHEGc6rs2lt44Bnjm+WXgYu4HBWMBJINREJUwJpe5vpGIs3U61M7gQ
         /8z8DcMTSv6GluH9a+NEmpiKYuL6NjLGXDyofqfRdw3IkBxUH6m0ww+TRPoqGqZS13Jm
         zpMBdzVBooSXRZ2Ozo/pc2mbgF2ylR9RqewjC1/IhOZGvZBxknFsQdyFcXm9oYNnMrRR
         hwmG//I4fNLrlImQtNCwG/RL7m6s3p8g6DTtCayyFJTQKKewb81vTVUlQ2Sqv0fIVRSm
         bLdA==
X-Gm-Message-State: AOAM531flvusoEaOEMQZh0s+IUBAtFuD8Ap+M7eehFXGtqepugZ7hWYX
        S58vV2HqBwI8IggS+2/ifMFd3A==
X-Google-Smtp-Source: ABdhPJxiWSn2FG95SA76dSXfh63IIlA1JbMOT4SlEzlrg7n8lbIUkNG860vEUcouEZ8VKy45Cf5TOQ==
X-Received: by 2002:a17:90a:6501:b0:1ca:a7df:695c with SMTP id i1-20020a17090a650100b001caa7df695cmr4587060pjj.152.1650033592553;
        Fri, 15 Apr 2022 07:39:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a3e8400b001cd37f6c0b7sm4868835pjc.46.2022.04.15.07.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:39:51 -0700 (PDT)
Date:   Fri, 15 Apr 2022 14:39:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Hu <robert.hu@intel.com>,
        Gao Chao <chao.gao@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v8 6/9] KVM: x86: lapic: don't allow to change APIC ID
 unconditionally
Message-ID: <YlmDtC73u/AouMsu@google.com>
References: <20220411090447.5928-1-guang.zeng@intel.com>
 <20220411090447.5928-7-guang.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411090447.5928-7-guang.zeng@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022, Zeng Guang wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> No normal guest has any reason to change physical APIC IDs, and
> allowing this introduces bugs into APIC acceleration code.
> 
> And Intel recent hardware just ignores writes to APIC_ID in
> xAPIC mode. More background can be found at:
> https://lore.kernel.org/lkml/Yfw5ddGNOnDqxMLs@google.com/
> 
> Looks there is no much value to support writable xAPIC ID in
> guest except supporting some old and crazy use cases which
> probably would fail on real hardware. So, make xAPIC ID
> read-only for KVM guests.

AFAIK, the plan is to add a capability to let userspace opt-in to a fully read-only
APIC ID[*], but I haven't seen patches...

Maxim?

[*] https://lore.kernel.org/all/c903e82ed2a1e98f66910c35b5aabdcf56e08e72.camel@redhat.com
