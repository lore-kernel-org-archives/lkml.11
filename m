Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC7DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 00:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357069AbiCYAut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 20:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357062AbiCYAuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:50:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E3943EE4;
        Thu, 24 Mar 2022 17:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C2BBB826FF;
        Fri, 25 Mar 2022 00:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0246C340EC;
        Fri, 25 Mar 2022 00:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648169351;
        bh=rjmJYiQgY1akn7Nl/HQbMNXWnvmQlSy6McuLLTA/aQ0=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=piWZNbAMJgatSoT5xZOBehw/787gdX7J2NFCFEg7hdeUOlTqpHyqQOZ2soAsgdUQo
         tNDvmVdE7C5dC5Uue5GtFm2NpjOdK1ju8gwbQvk/u+9JkBnhtCbFiHNnsRbLe/Jk9I
         YITQjYjV+OzZDyLfYkBh//OKskKOV5OW58gE4DAwzgbCMOVr2XhU3vcldt78BlBsnS
         dEhd3JsMSKL0/EGETQWqywgKHBgaeZ6YLQ+mPKyyjGujJZRLI5eAzvmN0xGwl39mNh
         g5QZ6Ym+OXhANLLLqIvisZ3+BOBtLXYbBdT4H9bOJkCMhDOp9YUkP05/qcRZpyxRGX
         kzJIU/v8CiSMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220323194248.26970-1-ansuelsmth@gmail.com>
References: <20220323194248.26970-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: fix dt_binding_check error for qcom,gcc-other.yaml
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Mar 2022 17:49:09 -0700
User-Agent: alot/0.10
Message-Id: <20220325004910.E0246C340EC@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-23 12:42:48)
> qcom,gcc-other Documentation lacks a '|' for the description. This cause
> dt_binding_check to incorrectly parse "See also:" as a new value.
> Add the missing '|' to correctly parse the description.
>=20
> Fixes: a03965ed1310 ("dt-bindings: clock: split qcom,gcc.yaml to common a=
nd specific schema")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Applied to clk-next
