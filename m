Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586BDC3F6B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiHXRQ6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbiHXRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:16:56 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B97C192
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:16:55 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v125so20171378oie.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xH1Eh5z9tkUCDvtKIBQEtl0pleKDswE2sHWuXsvAcw0=;
        b=NsQBcHWGLr6oKTDzceDUWnHHpP7nUmIJa/T1MYZjObZKbcmEaYGtC3QHf2cMnptmuB
         +DIHBikwmq4vqES5qVSv+ILUA5HZbOYmtabmfRarE872HH2gC5t40PJsuj3INT/jfGI6
         98swjjo91Qcj16FVsGmWU/KVXeUEzSMoUDXhbH2HfnAP9JmEiao/SD4h4RTqWVnnE6Z9
         Rl5B0bGRew5yX7LmB08tSGtXR+PH/UqniywSKypYn0ZwYel64JvKcMTOZ6jiYI6STq5S
         NjyFEpKE/I3//FdFd2MU40jiTUBI91bVckHJEk7UILlyuYMU0N0DS7gBnHCa06yLJY2D
         eDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xH1Eh5z9tkUCDvtKIBQEtl0pleKDswE2sHWuXsvAcw0=;
        b=5Q99Sz12Ez6v6htcAk3g7ai+ehVTj7armP1wQkW50Pe04upbUoTBabmMkHvUxun+Y4
         vQ6r73WwH8op82yu+QaYB9kkc/noMSMcxnt447m81/OHp7AcWQ832qFk4uTqOlsDyFW8
         vN6NIKYaKB92u5xCBZ9OItWoo2f9Culh0DmSyERcNfcABI/yL92/ldeBcthK0pLSTOKG
         qYPntZ80yO4TrIJiY5sL0ppY9Im//8/xELphkBrugms3uzg/N8RDfqE8qQNN0tE3OvW6
         TZNXjvXNqGb9FOMasrnD6ukJ/yuO98hF1ym2Uo1rcNKtRZYK5kVeGRqUK19117OorN56
         f0MQ==
X-Gm-Message-State: ACgBeo0uxnD8Lu/KVLLbrv3sh7KU9ynOuVFJOlH0pNAxQRFL7TqlPGdR
        W8QSjYyhfFEZVn6+GMJWIH+1QnH5PNwgQ4gKS7ZF/A==
X-Google-Smtp-Source: AA6agR5DvE8z8vHQGiXGONrNTnfLOoN/gC8Pk9vmYNfXaeUyq1afrkIGeTkjg4811k+u7x6T4BhaIhxgfE2UecdRHAs=
X-Received: by 2002:a05:6808:150f:b0:343:3202:91cf with SMTP id
 u15-20020a056808150f00b00343320291cfmr3657938oiw.112.1661361414498; Wed, 24
 Aug 2022 10:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <163244601049.30292.5855870305350227855.stgit@bmoger-ubuntu>
 <CALMp9eSKcwChbc=cgYpdrTCtt49S1uuRdYoe83yph3tXGN6a2Q@mail.gmail.com> <e3718025-682d-469c-eac9-b4995e91dc11@redhat.com>
In-Reply-To: <e3718025-682d-469c-eac9-b4995e91dc11@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 24 Aug 2022 10:16:42 -0700
Message-ID: <CALMp9eQCcy-MjB8Su+654XyL3zfR876tdh4QHUjvB7EiNjCU9A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Expose Predictive Store Forwarding Disable
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Babu Moger <babu.moger@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        joro@8bytes.org, tony.luck@intel.com, peterz@infradead.org,
        kyung.min.park@intel.com, wei.huang2@amd.com, jgross@suse.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:13 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 8/23/22 23:26, Jim Mattson wrote:
> > For consistency, should this feature be renamed AMD_PSFD, now that
> > Intel is enumerating PSFD with CPUID.(EAX=7,ECX=2):EDX.PSFD[bit 0]?
> > Seehttps://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/cpuid-enumeration-and-architectural-msrs.html.
> >
> > And, Paolo, why are we carrying X86_FEATURE_PSFD as a private #define
> > in KVM rather than putting it where it belongs in cpufeatures.h?
> >
>
> Borislav asked to not show psfd in /proc/cpuinfo, because Linux had
> decided not to control PSF separately; instead it just piggybacked
> on SSBD which should disable PSF as well.  Honestly I disagree but
> it's not my area of maintenance.

Do we expose PSFD in KVM for the use of another popular guest OS?
