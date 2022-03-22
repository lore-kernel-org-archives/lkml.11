Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6084C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 00:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiCVA6F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiCVA5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:57:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC283AA48
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:56:27 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so6142107otj.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=vHRjvPtgb9IHetN+vUEA77OxoeMKGMiBCKYOyIGVohI=;
        b=IjHJF5PMmAj7LfEm03fjvPDvBXlAUuwaXBqUP03ddPmJcmUUoBFzmTLGbhIJMrDqbe
         oUg/OenAw36c95uegEZo518oPNbJQUtmRQUZ01aAkd8LWcIbt90gXmpV5JXNLcx6Z/5C
         n6betOcE88SPr+J3GsiSPMo1rw+PVs9l0SIsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=vHRjvPtgb9IHetN+vUEA77OxoeMKGMiBCKYOyIGVohI=;
        b=kcA6ctXrUf93mKHVPGvpf7eRO3xbcbsPB4LcNAV1JPwrcMEYbF75nq9D7VthP+zjqD
         mas6jomc2dKE3O//QWBd4kjmyKnCS5WT9TnKJiftoLMFVgr9DunhO/jd2TVMhNUWMOcq
         yh1tryhpZhT1t106jPCvFP1wjiI353TWvHpeIR4iQSqpPqCIPaE4ZLtd7yEOriJp+Umv
         iwVJff3zgLGu/0QXZ3OwR6qiswQ8ktTNmgYLAMXF8p0BGoswdejvsNIE2KoQB1yEIiJp
         IAoLcJSqPNzfjaEoJ07tXuR/UtrT8c4dBGlNYWrzybAWzi+/DPn9KaV9SNpaozlMCaz8
         eDcA==
X-Gm-Message-State: AOAM531JvFLJ63NJjTjc2hsk6HpWc7Q0S5Z7IyvOBphDr+sinUF4M0b1
        K59+Z1Zmm+nRaYVlbhelFqc094srcD9AUL13GsIIXP01tGo=
X-Google-Smtp-Source: ABdhPJxk/fuFNPAUltwZKzz37MDph4y4/NYbVKyFjV1ThFVvRyLs53JJhnLi8P2uueF0mEImRY5PdOJJbwbRkepmhUg=
X-Received: by 2002:a9d:b85:0:b0:5cb:3eeb:d188 with SMTP id
 5-20020a9d0b85000000b005cb3eebd188mr7614017oth.77.1647910586937; Mon, 21 Mar
 2022 17:56:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Mar 2022 01:56:26 +0100
MIME-Version: 1.0
In-Reply-To: <20220321161546.1.Ifc4270fbe9bad536f08a47696e00cca5a0714abd@changeid>
References: <20220321161546.1.Ifc4270fbe9bad536f08a47696e00cca5a0714abd@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Mar 2022 01:56:26 +0100
Message-ID: <CAE-0n53RyGP53zySwTZaFJ+OKp9zJahBg76ZmKsaQ=fsddgu5w@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: socinfo: add SC7280 entry to soc_id array
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-03-21 16:15:55)
> Add an entry for SC7280 SoC.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
