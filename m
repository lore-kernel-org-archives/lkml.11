Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BD8C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 05:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiHWF5I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 01:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbiHWF5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:57:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA05F9AA;
        Mon, 22 Aug 2022 22:57:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z187so12466355pfb.12;
        Mon, 22 Aug 2022 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=wba++hNYKujP92jadbFXJOrr+LMYVSuHYzCujRc8nWs=;
        b=MJtLNvzGxuhy4gjHVj2RhkpKA0w6/EW9v6DENcEk8no4XfZGaUKOHvio5hSDyyrx4Y
         6sf3fj3ecKdt1dpr5Lh4aUxuavTRn81+OcDnCFkPuubP+BQvliwMGl/dWS5n23Raiscv
         XJ3ent+D596NikjVU7subGMBAylF0RehF3+W3H3HYbfWpVaDlCVkIlxIhBTrYqEU8NsE
         Y8QbRRJZQLbTMUfAl9wwsXmo08cEnr4FLlKhDExFlY5UV2FcNkHueAn82lcii9NrBekm
         2RGt8rKr5sRgqy++n4YNnr9tf4oOJif2Jp1VUCnRw/L/8Dx3oFhc6Rf4IVE/elL4ZFw0
         QlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wba++hNYKujP92jadbFXJOrr+LMYVSuHYzCujRc8nWs=;
        b=B3engWgpAQcZ8AXq7+H+AHV4IdnUXbzjXXkJkfbHS9yqWkPVgC8ET2zmf+2/Wu0fap
         1zxQ3OorrN1FAJ3XOUeTvEld01bnHDEo30iCqh6ONLbnvUFozGR6S6JARYJfvGGO+On6
         zVWuQkI3nVk0SqLkP+0cmrCxlk1DGC8Zr24WUeXd6rPTmZ8/HT9G1E53cDaxSf1JMiOv
         jTuK0GmeB2HX/v0FFutZYyC4aS0rZouJdimREQ/oOcE3I3p/2mWjAE/cvFvScvqz83EP
         Rwg1DR49CpCKfJGTlwHotWf3fGuPCQBIs9zIuGb7AKYEYtxKI07Zw9zo71hHkVUkOl7n
         +Z8g==
X-Gm-Message-State: ACgBeo3njGLhDjXqQNoop0jCqL1BblQEdLfQKCGeSZJRpNfu+ux61RnB
        LjqZb5aMuvzvMK9rAsU2iBk=
X-Google-Smtp-Source: AA6agR4lKN5Jw/QeydnjJ6lS02vonnDNYFxbOrzc2gCQCct/zwI1pIza5foKEo1+o0OruhhTR+UFWQ==
X-Received: by 2002:a65:6e46:0:b0:42a:2c7e:4232 with SMTP id be6-20020a656e46000000b0042a2c7e4232mr17546550pgb.611.1661234224158;
        Mon, 22 Aug 2022 22:57:04 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id b84-20020a621b57000000b0053674c0f9d2sm4344677pfb.116.2022.08.22.22.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:57:03 -0700 (PDT)
Date:   Mon, 22 Aug 2022 22:57:02 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        isaku.yamahata@gmail.com
Subject: Re: [PATCH v2 0/3] Documentation fixes for kvm-upstream-workaround
Message-ID: <20220823055702.GD2147148@ls.amr.corp.intel.com>
References: <20220817124837.422695-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817124837.422695-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Aug 17, 2022 at 07:48:34PM +0700,
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Here is documentation fixes for kvm-upstream-workaround branch of TDX
> tree [1]. The fixes below should be self-explanatory.

Thanks for patches. I'll merge it into the repo.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
