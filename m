Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8804FC19F2A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 17:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiHKRHg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiHKRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:05:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D20EA8B6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:36:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t22-20020a17090a449600b001f617f2bf3eso5841884pjg.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yQQeBGMFRhJHqkBrliQLlLMhGDgr93041o3JbsxLdP0=;
        b=f0Y97m5uFoTjMQUKrRexPwcFC1iookwhVumI2WNsBH80pPBuXyNElI2rG2qBDCu7qO
         T8yCFTJPq18Cy0348pc+Cucq+jrx/U9A5fJxVUAqbo3xN6D+yWmzsx2oTWBi4K67rCTW
         MpeJ9YRpcF1VmoSImPpcbbRZgrjizRI0GlbF1NakZaXKLvJ5P4EoTBxPEFjzbXFhGvOT
         ArR+i6xGVWVk5PcJZ3C6Pj4lj7tpIsNMzM51tkl5qITjXhuY5luSRapytx3Uqh+TH/5H
         yNePBOZb6UYl3L3zMygzFcOyTTWw6Mv8x8AhtkNMceofVPrOlKHUSKUurjKysT7amwoK
         h9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yQQeBGMFRhJHqkBrliQLlLMhGDgr93041o3JbsxLdP0=;
        b=14Ulqhu9Dj7i00nNMyeqwSH57YJh9WFHum3NXbLsthcSsGGwhpf/HO6QtIMD++LIGm
         fYERnKzF60qMARrkFX5pstliaFttTlbfYGfe0RlS3qJOxuSHoBElbN2aTHjDIZkbn0f0
         3xj0KpQopcb3Acz6v5Bvfck5ntL18x/lsH+EqQZXZZyRs0CAPbjSaLg0Ca6tLWe803cF
         NBuU9oHXCpPTHowlhuKeYF5J9sRTCSBvZMruayzFjYwyRHUmLTyw+Eb+cQpHj8tSS6iH
         DJdETauwAJwcWmSTFt2z1W7wYgy59NOeDC8k4Rw+up+sD7d6RKJmRpToSbkpQrEhapKt
         oxIw==
X-Gm-Message-State: ACgBeo1QF1HwdiJRBRFggaEMciyZ0K+zHgkGW/F2OlXDADz+ArTxKQ9n
        Qi54BTUM5zoCkCctZa498n+I+Q==
X-Google-Smtp-Source: AA6agR4X3X0Tp65+0VAvDzI0xmtNZkiBcym4hl6k5bgk2jVKYmgD/SdQuv9S2E16swSiddLHC9c7vw==
X-Received: by 2002:a17:902:e746:b0:16e:f7cf:671f with SMTP id p6-20020a170902e74600b0016ef7cf671fmr109605plf.168.1660235770052;
        Thu, 11 Aug 2022 09:36:10 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b0016b81679c31sm15039246pli.213.2022.08.11.09.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:36:09 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:36:04 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: dwc: add support for 64-bit MSI target
 address
Message-ID: <YvUv9Pt5PiLPAuTu@google.com>
References: <20220809180051.1063653-1-willmcvicker@google.com>
 <20220809180051.1063653-3-willmcvicker@google.com>
 <YvTKTCABejYZERnh@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvTKTCABejYZERnh@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022, Christoph Hellwig wrote:
> On Tue, Aug 09, 2022 at 06:00:50PM +0000, Will McVicker wrote:
> > +	bool msi_64b = false;
> 
> Spellt out bit here?
> 
> > +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> > +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> > +		msi_64b = msi_capabilities & PCI_MSI_FLAGS_64BIT ? true : false;
> 
> No need for the tenary operator here:
> 
> 		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;

Thanks for the suggestions. I'll update in the next patchset.
