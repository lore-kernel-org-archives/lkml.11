Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A07C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 14:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiEIOkc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiEIOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:40:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176B18AAAD
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652106995; x=1683642995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mjn/CYwCRlv13/LGy7FwFtcBgG/kp96cuyTiCnHpROQ=;
  b=h8XL3zJBSdBSQlwGwldz51cjsOCNjKghdj6x59CEh277zp3ptFIxpAic
   2x0K+w5z/XEc5bMpycuGbf03bzmF74aUZNwyMOQtgQ9Sy7nz5ths69bc1
   eCZS1jVIxc6yPuItNhtr42uKW99D+MftNo7NU+SpFyZVJaN/oG7jVdjtk
   4BY782zKQ4HkpP76WaGANGKDMtI1afDCwDUqBrwVZXP8zbWOOBFPcPdcN
   dJM6gmXVHZgbvpbTz6H47kHYEDM3CRmfyZ3oDI8VNtou/logHnmn0yWbE
   8iAMveW1KP+RiNX9fAruDpU7pmEsQqXeYvadxIp+ELH4R6YkPlJZ9j/mS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="294292953"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="294292953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:36:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="592550916"
Received: from gfgerman-mobl1.amr.corp.intel.com (HELO [10.209.80.95]) ([10.209.80.95])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:36:31 -0700
Message-ID: <0d645ee0-a54f-d9b4-9392-06ea1c37b29a@linux.intel.com>
Date:   Mon, 9 May 2022 09:36:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] soundwire: qcom: adjust autoenumeration timeout
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20220506084705.18525-1-srinivas.kandagatla@linaro.org>
 <725af523-d144-e373-e09b-fb48b3afb9ed@linux.intel.com>
 <8643d266-7108-2440-43e1-c51b829ba481@linaro.org>
 <d9646029-29b1-d71b-d1f5-b33267888e3c@linux.intel.com>
 <fd355232-c5e3-ba1b-801d-526ee6f04946@linaro.org>
 <97cd6566-e686-e1f2-fe91-4b4ba9d95f12@linux.intel.com>
 <d17db27d-ad1b-f52c-50e9-4aab78ae0ff0@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <d17db27d-ad1b-f52c-50e9-4aab78ae0ff0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Even if enumeration timeout, we will not access the registers because
>>> the ASoC codec is not registered yet from WCD938x component master.
>>
>> What happens when the codec is registered then? the autoenumeration
> Codec is only registered after reset and when both TX and RX components
> are probed.
> 
>> still didn't complete, so what prevents the read/writes from failing
>> then?
> If codec is reset and registered and for some reason autoenum took more
> than 100ms which will be hw bug then :-).
> In this case register read/writes will fail.

Does this reset result in the 'bus reset' in the SoundWire sence and
restart hence the autoenumeration?

It looks like you have a race between different components and starting
the bus before it's needed, no?
