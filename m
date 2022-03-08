Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD57C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 13:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiCHNKq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiCHNKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:10:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7D5FE1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:09:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so1397994wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 05:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jIHKyDto3VNe0jan3Q4InEbXVdDFGcIeT9QW9S/Z1yA=;
        b=jbpt5SwnC5KT4ZXh7IxtNsrgGcj7VVb16w1WO4pHVIMxgFqMDC2JVfEPhSd28qEdum
         FEhf6akwghJ1GAdNEziVNhjKIH5oZhPKAHZWQn6kvsYB/rvdJu07tyfVVUP6n59UEdZk
         a+sTDSQY7s5diyafXaq1avAkL4tv1Cp+14rasUL2eS3xOajI9/1d7j8SnSIO6wy42QFf
         DzGN68fI4s1xdo+a7Oa3NAQYmyxk0T39uRam8sUb6a5aU3aUStstOpNCALE5ceUStn7d
         e9YqUUHzXiq0Fu2QMKF1xi1HYTKkgTe6tmCUVMcZV3yg/ygNVYX8oG0ShH4xujfam9L2
         B5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jIHKyDto3VNe0jan3Q4InEbXVdDFGcIeT9QW9S/Z1yA=;
        b=aPdqiKyvToWHX1JXfkrTuI0CZuI6Ed0loa9q3iQ2WnuM71c6PB1KsUatIWyr4iF/zV
         oeiSJFYFtUGZB24qYmONnm76dF4IKpkTr5HWTFNOTR5yU9SEHs/FG+qa8D6XVWA/JUKj
         wNcyB3Robri1f4OTmc3rTQVLtyHpsVomXk8gdksFHSs4eWlgWYt+XQW2RFmgZaMqES1U
         0WGkwMHFwH4IMqpbttBxhrEK1EHu7mbbck8xJYRGMXrfalq5MSHMlm8/3vv3kwVFDFpS
         inRS8WKHL6IKVsmD5FDokxFkfwohL65aEjXtnUT9W6Ml0T24vOuPV42vLkDXGTMgZHcG
         tS8Q==
X-Gm-Message-State: AOAM5328+tmM1ErPh+8s+wbJsFO2gIiJmO3R5kMZw5iIIBbVI3Dci7o4
        9lxYKUMsJTgvYlA05AtScTmSsg==
X-Google-Smtp-Source: ABdhPJyMETb54ZQiFJs9pNCVwtDVfsBQoRRZgo7hsLXgxVZq02upIxNHSYYzogAJuAPCDIJ/7we1ew==
X-Received: by 2002:a1c:3b8a:0:b0:380:e40a:289 with SMTP id i132-20020a1c3b8a000000b00380e40a0289mr3481063wma.17.1646744984144;
        Tue, 08 Mar 2022 05:09:44 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id z6-20020adfd0c6000000b001f1ffd04672sm4048217wrh.12.2022.03.08.05.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:09:43 -0800 (PST)
Date:   Tue, 8 Mar 2022 13:09:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [GIT PULL - FAO MARK BROWN]: Immutable branch for MediaTek
 MT6366 due for the v5.18 merge window
Message-ID: <YidVlV8Rg8N5TT8A@google.com>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <YicTu6FwOR7zIC6I@google.com>
 <YidQvkIYsacSPsXv@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YidQvkIYsacSPsXv@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2022, Mark Brown wrote:

> On Tue, Mar 08, 2022 at 08:28:43AM +0000, Lee Jones wrote:
> > Mark,
> > 
> > This one is just for you, so you can merge the other patches.
> 
> I don't know what the other patches you're referring to here are,
> someone's going to need to resend them.
> 
> I'm also not sure things like like "FAO MARK BROWN" in the subject line
> of the e-mail, I can already see if a message has been sent to me from
> the To and it means less of the actual subject is wrapped out of sight
> in my inbox.

Might be time to upgrade your VT100!

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
