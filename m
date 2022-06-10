Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8CCC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 07:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346809AbiFJHgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346731AbiFJHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:36:03 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4F532C1;
        Fri, 10 Jun 2022 00:35:59 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DC1E31F714;
        Fri, 10 Jun 2022 09:35:54 +0200 (CEST)
Date:   Fri, 10 Jun 2022 09:35:47 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 04/11] drm/msm/dsi/phy: Reindent and reflow multiline
 function calls
Message-ID: <20220610073547.meftbrcxk274kxhq@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jonathan Marek <jonathan@marek.ca>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220601220747.1145095-1-marijn.suijten@somainline.org>
 <20220601220747.1145095-5-marijn.suijten@somainline.org>
 <CAA8EJpqU6y3YKfZpgKORCfns-LN81NhqOetQbBC_Z4gVdMQakg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqU6y3YKfZpgKORCfns-LN81NhqOetQbBC_Z4gVdMQakg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-02 13:14:26, Dmitry Baryshkov wrote:
> On Thu, 2 Jun 2022 at 01:07, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > Patch 613cbd1da3c9 ("drm/msm/dsi: use devm_clk_*register to registe DSI
> > PHY clocks") introduced the devm_ prefix to clk_hw registration calls,
> > without updating the indentation of the arguments on the following
> > lines.
> >
> > Similarly e55b3fbbbbc8 ("drm/msm/dsi: drop PLL accessor functions")
> > moved from pll_write to dsi_phy_write without updating the indentation
> > of followup arguments either.
> >
> > Preparing for a series that heavily touches the clk calls, reflow and
> > reindent function calls that are adhering to an 80-char column limit by
> > spanning multiple lines.  Where function names are very long the
> > arguments are indented with a fixed number of two tab characters instead
> > of aligning with the opening parenthesis of the function call.
> >
> 
> I'm not a fan of reindenting the code, but let's do it.

I don't like it either, but it's better than trying to figure out how to
add and flow new arguments into the call-site while also leaving the
indentation in the same broken state.  At the same time it seems more
consistent to fix up most faults rather than only touching clk calls.

It's unfortunate that there's no proper autoformatter for C, that is
consistently used across the kernel tree.  Makes for a lot of mundane,
error-prone, manual work.  But alas.

- Marijn
