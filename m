Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E5CCA47C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 10:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiGFKgF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiGFKgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:36:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BA8B1E;
        Wed,  6 Jul 2022 03:35:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so9984771wrd.13;
        Wed, 06 Jul 2022 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=KBBe1sXw+OvOoMBGDgq+/LVehb93MMTHSQ7lhj1tzyc=;
        b=eWlqEXGgSssDtjj0zt3fmQJU5ZXzuhdVeftxszhTF2XKpjodmgmtiHeMXUMZDHjE1x
         oNlFlUr0oEwbUqBf0OmGcuQn/gHnqaLCZG1xhyOPKCKDBcsse0N0EWBwVuI+z2HfKWvq
         108aOW/967Wy8gLLRdrroTtvKkkHMp65LhyL2c/KOGy1mbqHA48fZhmqPL1BtcvHPf2Z
         Dkayz+dkfK4oS1/0rnhiiCJPD4GerZO5l3dZ+UO7MEY/CqQdkNAdfLo2zONSY6HSKCoH
         3nKoKe0U5HwAuF028wnmFNzlg20qdOU6mMVd88bmD6ABE6gaIL3lcV/4VbrIwcQieFY4
         nrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBBe1sXw+OvOoMBGDgq+/LVehb93MMTHSQ7lhj1tzyc=;
        b=Jc87qoiJDB/pakIFmvM9oLzBJ08VMNIz1ohS3098/D0G7Rc7PuOwCXDK3t4716o2no
         umiCQuYcemOPKPwsDjelLqAWSMGlRkxrV+Htw/A1182D1sHuEIFUko3VIyP6mTRqd+1T
         7hC94LSH05GcAg0VZMzNXDQIJqucdnGHzUu7nT4yk8V3WZHMj+DC2s5jhes91V0JTO2Q
         qyPXb2FUy11ZmRIdPPSMX+aY527DWhoJkogjVT6tGhOwPzi+F9qQHij36LAskXHp3CuJ
         nXXvYwTdZdd36/v6zE85xVHc4+FA9NFv3+2/uksUE08/A3xecTCQBeIgGA/anp20Mva1
         NMQA==
X-Gm-Message-State: AJIora9Y1ZH6xvnLZN1eQHjYeS4WFxPVbtYfun8cDlVZdl543ikMT+DC
        Nbt1aLZWNU5EE/GYr+FNs5U=
X-Google-Smtp-Source: AGRyM1uzMhA/xmuV812rz7IMzLdVhJ4oNCHJPcmFPJSfIZJ8KoE3xQf6AdF2nD/vIlAUbXvrNhmB5A==
X-Received: by 2002:a05:6000:18d2:b0:21d:6661:60b5 with SMTP id w18-20020a05600018d200b0021d666160b5mr17782534wrq.475.1657103757864;
        Wed, 06 Jul 2022 03:35:57 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id h15-20020a1ccc0f000000b0039749b01ea7sm33768215wmb.32.2022.07.06.03.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:35:57 -0700 (PDT)
Message-ID: <62c5658d.1c69fb81.1dc23.6884@mx.google.com>
X-Google-Original-Message-ID: <YsVhqBMmy0WZbPon@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:19:20 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: fix wrong clock documentation
 for qcom,rpmcc
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-2-ansuelsmth@gmail.com>
 <CAA8EJpoXOwooUYic-_G6jG7MBiHo2mfoKfR0jBDmRy0DsmMNEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoXOwooUYic-_G6jG7MBiHo2mfoKfR0jBDmRy0DsmMNEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:23:46AM +0300, Dmitry Baryshkov wrote:
> On Tue, 5 Jul 2022 at 23:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > qcom,rpmcc describe 2 different kind of device.
> > Currently we have definition for rpm-smd based device but we lack
> > Documentation for simple rpm based device.
> >
> > Add the missing clk for ipq806x, apq8060, msm8660 and apq8064 and
> > provide and additional example.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/clock/qcom,rpmcc.yaml | 77 ++++++++++++++++++-
> >  1 file changed, 73 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> > index 9d296b89a8d0..028eb0277495 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> [,,,,]
> 
> > +
> > +then:
> > +  properties:
> > +    clocks:
> > +      description: pxo clock
> > +
> > +    clock-names:
> > +      const: pxo
> > +
> > +  required:
> > +    - clocks
> > +    - clock-names
> 
> I don't think you can not mark these properties as required, older
> schemas do not have them.
>

Well considering we changed rpmcc to parent_data and rpm clock require
pxo clock as parents it seems to be they should be required.

Actually no idea why this wasn't required before. Probably because this
schema described only rpm-smd and not old rpm?

> > +
> > +else:
> > +  if:
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          const: qcom,rpmcc-apq8064
> > +  then:
> > +    properties:
> > +      clocks:
> > +        items:
> > +          - description: pxo clock
> > +          - description: cxo clock
> [...]
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
