Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76466C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 17:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbiCBRnH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiCBRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:43:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AF39C9A3F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646242937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZRowazjKHkSwG91bEeLTG0Irzd+flVDD4PprZAWlSM=;
        b=bk1YyCFbx9+dzliodH8k+74XBwrunt6v4eZHXctoY6F30LkbKDhIX6cNLTa+/3gJANLWpJ
        bVdewOLW6c2ymB+vyO0x5m3iOcF6drm8z2ASJnC2EGlPru6VTPAsjsiVYwg7SGTum0pAg2
        43SxMizyHlnrDK7RDjIxVpfnNxJMPhI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-Rto3RHmANfaLJ40dNqieEQ-1; Wed, 02 Mar 2022 12:42:16 -0500
X-MC-Unique: Rto3RHmANfaLJ40dNqieEQ-1
Received: by mail-qt1-f198.google.com with SMTP id w11-20020ac84d0b000000b002dddbca1e3dso1775129qtv.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZRowazjKHkSwG91bEeLTG0Irzd+flVDD4PprZAWlSM=;
        b=OGxCNZVugcMQFlO+cT/s6EcQcqLyD1FK4WH8erbMmmP+MnaP/8DiKqf88s+KbOypUj
         BGGan+PYslHw9afr4h4pBS7S2Au+A9htMOTNMBMjQDO9uN9KWsaUGTa/Wj7oXVRbi0sC
         Gzn3tE/dqOBq/2MlTW15HWmnJ5y7Zx5e7C5FsX7zJIZ/Dj+dbMwl03qt4+T1JYauGYxG
         h1BIrqnE9ae1/5y2VnFqa0LZheBfzmb+zbuxEC11Kbnr8c3m9wRWznBrrGQSFkSy71/T
         i/nR+LSwl0+5ST4OPv+zKAmmHr+0Tp7yhSf4m0Jn260wXz5R7wQ/ohiZwJCY3MOxLwMn
         EM4w==
X-Gm-Message-State: AOAM530eZLXHOCrVTopudD8oOcFbygV+gsxc0KRPSFdjxcAeLrdeQmQs
        fU4u2UNeeBgfYrwKa5R+5kSZQ/omK0dnQaZViTP+8CqkD2KDGHyEQQiYSxZ8hdIjxB2N1s+BaSa
        3lIK7HncwACfn3wTYjJ0iVh/o
X-Received: by 2002:a37:aa02:0:b0:47e:826e:7d4e with SMTP id t2-20020a37aa02000000b0047e826e7d4emr17044293qke.9.1646242936162;
        Wed, 02 Mar 2022 09:42:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy86+Az9FIRHE+NvBlKTd4p8kDl+YQS970wIGOdl+ZSB3ucpiwQTYM6k2Sfb7Hb/wXJMvsfow==
X-Received: by 2002:a37:aa02:0:b0:47e:826e:7d4e with SMTP id t2-20020a37aa02000000b0047e826e7d4emr17044264qke.9.1646242935878;
        Wed, 02 Mar 2022 09:42:15 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a111200b00508188ead26sm8325555qkk.97.2022.03.02.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:42:15 -0800 (PST)
Date:   Wed, 2 Mar 2022 09:42:10 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv5 15/30] x86/boot: Port I/O: allow to hook up alternative
 helpers
Message-ID: <20220302174210.q5r6zl2lsa6hut6q@treble>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-16-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220302142806.51844-16-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:27:51PM +0300, Kirill A. Shutemov wrote:
> Port I/O instructions trigger #VE in the TDX environment. In response to
> the exception, kernel emulates these instructions using hypercalls.
> 
> But during early boot, on the decompression stage, it is cumbersome to
> deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
> handling.
> 
> Add a way to hook up alternative port I/O helpers in the boot stub with
> a new pio_ops structure.  For now, set the ops structure to just call
> the normal I/O operation functions.
> 
> The approach has down sides: TDX boot will fail if any code bypass
> pio_ops and go for direct port I/O helper. The failure will only be
> visible on TDX boot (or other user of alternative pio_ops).
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Sorry, but this is still not convincing.

As you said earlier, it's a judgement call.  So, detail all the
considerations which were used when making that call.

Why is this the best approach compared to other alternatives?  It needs
to convince the reader.

Supporting #VE -- by building on the existing #VC support -- seems more
robust than this hack.  Convince me (and other patch reviewers)
otherwise.

At the very least, please remove the ability for future code to
accidentally bypass 'pio_ops'.  Going forward, are we really expected to
just remember to always use pio_ops for i/o?  Or else TDX will just
silently break?  That's just not acceptable.

-- 
Josh

