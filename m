Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50EAC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 01:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiGLBGx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 21:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiGLBGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:06:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDC527FFF;
        Mon, 11 Jul 2022 18:06:49 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 72so6264737pge.0;
        Mon, 11 Jul 2022 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AGvha80V0MRiN4HscNR3tkUtu2VilgnnAfsi2jxRBVA=;
        b=jv1jywBoSaitglhyd6Vh/crbdp1Vd1GQ8+y0MhQVwocuEccPS3ws3FKZOMwhN6kUgP
         AgOjibYm56vDdDYeSBzLSkCYUa89t/iOaZMI9lDcauHExUL6oAZ2uVWtzXGVyFxaEXwY
         BIYhW/RX+bRKrhxZ2rtRf2D3jsurwYyuIap9Xz+TcfoOqz40TwG5N2KAxGhFh2CTMJYR
         a6bzLjed1txFFHml4fj+VJQzZRCCenzUa6dMYdxMdwQpeW/FM5dRy/EILjDvzD7VDADK
         2D4QJijAqRs1CEJxfle601ESXWgH9etqqyVnUmZyBnJpMVo3C7+ZsJ7c0xnn+4jcVGhf
         M7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AGvha80V0MRiN4HscNR3tkUtu2VilgnnAfsi2jxRBVA=;
        b=YXpWtaEVWF1CVi359DmOD/we+bcVE9ImyFd+4SNHUDqQnuhBmXp8tzn/n6LDBWIelw
         tbs7ut1Cg8pJivDyK2djuGO2H4wjZCt/H+j3KxJgb0ckhgA5AJSw/N0YHbpDoV/eQrz3
         jAR1mTviAhxNImEEas8ab9imm/mL2rgRniPCA3A0kHIQ4GgdEdIO9JyN2GaIZ7Npkhx1
         6SGKJMZOi3vWYowJyqrGBOARI5acsvbO8BXDy0xM59OOfE6C5vIvcCw8ylMXulUawx9c
         6cHGtveOhTvrtSGV9lXUhtbEw2L3zyCa/5oDvwWZeKmzWsVdKsk/rD6bl+0dcOrH6ZOx
         Sztw==
X-Gm-Message-State: AJIora9dVZ0fPCRfmeZfWlggme/9DaPfvsZ975uDcuAuBmHB3e3mEupG
        ZMgStHE4qxpME22qcLvvhBI=
X-Google-Smtp-Source: AGRyM1srE1AdG8bpdskPE/4oE3L8ELV8hCrWt33Ow6P6aPLd00EeAg+BsSsNfIoXMaYC7qh1PPaJ0g==
X-Received: by 2002:a63:2684:0:b0:415:18d8:78dd with SMTP id m126-20020a632684000000b0041518d878ddmr18866628pgm.33.1657588009396;
        Mon, 11 Jul 2022 18:06:49 -0700 (PDT)
Received: from localhost (fmdmzpr02-ext.fm.intel.com. [192.55.54.37])
        by smtp.gmail.com with ESMTPSA id c6-20020aa79526000000b0052ad6d627a6sm1965061pfp.166.2022.07.11.18.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:06:48 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:06:47 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 013/102] KVM: TDX: Make TDX VM type supported
Message-ID: <20220712010647.GF1379820@ls.amr.corp.intel.com>
References: <cover.1656366337.git.isaku.yamahata@intel.com>
 <038362fa9e89312ff72c01ab3ae3bbbf522c3592.1656366338.git.isaku.yamahata@intel.com>
 <20220707025535.7vn6ifx4wq52qwes@yy-desk-7060>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220707025535.7vn6ifx4wq52qwes@yy-desk-7060>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:55:35AM +0800,
Yuan Yao <yuan.yao@linux.intel.com> wrote:

> On Mon, Jun 27, 2022 at 02:53:05PM -0700, isaku.yamahata@intel.com wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > NOTE: This patch is in position of the patch series for developers to be
> > able to test codes during the middle of the patch series although this
> > patch series doesn't provide functional features until the all the patches
> > of this patch series.  When merging this patch series, this patch can be
> > moved to the end.
> >
> > As first step TDX VM support, return that TDX VM type supported to device
> > model, e.g. qemu.  The callback to create guest TD is vm_init callback for
> > KVM_CREATE_VM.  Add a place holder function and call a function to
> > initialize TDX module on demand because in that callback VMX is enabled by
> > hardware_enable callback (vmx_hardware_enable).
> 
> if the "initialize TDX module on demand" means calling tdx_init() then
> it's already done in kvm_init() ->
> kvm_arch_post_hardware_enable_setup from patch 11, so may need commit
> messsage update here.

Somehow I missed to delete those lines. Will remove "Add a place ...".
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
